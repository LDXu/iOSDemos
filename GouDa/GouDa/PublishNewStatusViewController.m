//
//  PublishNewStatusViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/14.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "PublishNewStatusViewController.h"
#import "UIView+App.h"
#import "UITextView+Placeholder.h"
#import "AppHTTPSessionManager+Quan.h"
#import "MainNavigationController.h"
#import "UploadImageView.h"

@interface PublishNewStatusViewController () <UITextViewDelegate, UploadImageViewDelegate>

@property (nonatomic, strong) UITextView *statusTextView;
@property (nonatomic, strong) UILabel *charCountsLabel;
@property (nonatomic, copy) NSArray *uploadImageViewArray;

@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation PublishNewStatusViewController

- (void)initViews {
    // navigation bar
    self.navigationItem.leftBarButtonItem =
    [UIView barButtonItemWithImage:[UIImage imageNamed:@"ic_close.png"]
                            target:self
                            action:@selector(leftBarButtonItemClicked:)];
    
    self.navigationItem.rightBarButtonItem =
    [UIView barButtonItemWithTitle:@"发送"
                            target:self
                            action:@selector(rightBarButtonItemClicked:)];
    
    UIView *bgViewForTextView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self.view addSubview:bgViewForTextView];
    
    self.statusTextView = ({
        UITextView *textView      = [[UITextView alloc] init];
        textView.backgroundColor  = [UIColor whiteColor];
        textView.font             = [UIFont systemFontOfSize:16.f];
        textView.placeholder      = @"这一刻的想法...";
        textView.placeholderColor = [UIColor appFontLightGrayColor];
        textView.textColor        = [UIColor appFontGrayColor];
        textView.delegate         = self;
        textView;
    });
    [bgViewForTextView addSubview:self.statusTextView];
    
    // 统计「还可键入的字数」和清除文本
    UIControl *clearControl = ({
        UIControl *control      = [[UIControl alloc] init];
        control.backgroundColor = [UIColor clearColor];
        [control addTarget:self
                    action:@selector(clearTextView:)
          forControlEvents:UIControlEventTouchUpInside];
        control;
    });
    [bgViewForTextView addSubview:clearControl];
    
    self.charCountsLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.font          = [UIFont systemFontOfSize:14.f];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor     = [UIColor appLightGrayColor];
        label.text          = [NSString stringWithFormat:@"%d", appStatusMaximumCharacterNumber];
        label;
    });
    [clearControl addSubview:self.charCountsLabel];
    
    UIImageView *clearImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_close.png"]];
        imageView;
    });
    [clearControl addSubview:clearImageView];
    
    [bgViewForTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    UIView *bgViewForImageViews         = [[UIView alloc] init];
    bgViewForImageViews.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgViewForImageViews];
    
    UploadImageView *uploadImageView1 = [[UploadImageView alloc] init];
    UploadImageView *uploadImageView2 = [[UploadImageView alloc] init];
    UploadImageView *uploadImageView3 = [[UploadImageView alloc] init];
    uploadImageView1.delegate = self;
    uploadImageView2.delegate = self;
    uploadImageView3.delegate = self;
    [bgViewForImageViews addSubview:uploadImageView1];
    [bgViewForImageViews addSubview:uploadImageView2];
    [bgViewForImageViews addSubview:uploadImageView3];
    self.uploadImageViewArray = @[uploadImageView1, uploadImageView2, uploadImageView3];
    
    self.promptLabel = ({
        UILabel *label  = [[UILabel alloc] init];
        label.text          = @"长按可添加/删除/修改图片";
        label.textAlignment = NSTextAlignmentLeft;
        label.font          = [UIFont systemFontOfSize:12.f];
        label.textColor     = [UIColor appFontLightGrayColor];
        label;
    });
    [bgViewForImageViews addSubview:self.promptLabel];

    UIEdgeInsets bgViewEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.statusTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgViewForTextView).insets(bgViewEdgeInsets);
        make.right.equalTo(bgViewForTextView).insets(bgViewEdgeInsets);
        make.top.equalTo(bgViewForTextView).insets(bgViewEdgeInsets);
        make.height.equalTo(@100);
    }];

#define kClearControlHeight      24.f
    [clearControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusTextView.mas_bottom).offset(5);
        make.width.equalTo(@74);
        make.height.equalTo(@kClearControlHeight);
        make.right.equalTo(bgViewForTextView).insets(bgViewEdgeInsets);
        make.bottom.equalTo(bgViewForTextView).insets(bgViewEdgeInsets);
    }];
    clearControl.layer.cornerRadius = kClearControlHeight/2;
    clearControl.layer.borderWidth  = 1.f;
    clearControl.layer.borderColor  = [[UIColor appLightGrayColor] CGColor];
    
    [self.charCountsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clearControl).offset(kClearControlHeight/2);
        make.top.equalTo(clearControl);
        make.bottom.equalTo(clearControl);
        make.width.equalTo(@36);
    }];
    
    [clearImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(clearControl).offset(-kClearControlHeight/2);
        make.top.equalTo(clearControl);
        make.bottom.equalTo(clearControl);
        make.width.equalTo(@24.f);
    }];
    
    // 「上传图片」区域布局
    [bgViewForImageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(bgViewForTextView.mas_bottom).offset(10);
    }];
#define kUploadImageViewWidth   60.f
#define kUploadImageViewHeight  kUploadImageViewWidth
    [uploadImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgViewForImageViews).offset(10);
        make.top.equalTo(bgViewForImageViews).offset(10);
        make.width.equalTo(@kUploadImageViewWidth);
        make.height.equalTo(@kUploadImageViewHeight);
    }];
    
    [uploadImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(uploadImageView1.mas_right).offset(10);
        make.top.equalTo(uploadImageView1.mas_top);
        make.width.equalTo(@kUploadImageViewWidth);
        make.height.equalTo(@kUploadImageViewHeight);
    }];
    
    [uploadImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(uploadImageView2.mas_right).offset(10);
        make.top.equalTo(uploadImageView2.mas_top);
        make.width.equalTo(@kUploadImageViewWidth);
        make.height.equalTo(@kUploadImageViewHeight);
    }];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(uploadImageView1.mas_left);
        make.right.equalTo(bgViewForImageViews);
        make.top.equalTo(uploadImageView1.mas_bottom).offset(4);
        make.height.equalTo(@16);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    self.title = @"发布动态";
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    NSLog(@"range.location = %lu, range.length = %lu", (unsigned long)range.location, (unsigned long)range.length);
    NSString *cacheText = [NSString stringWithFormat:@"%@%@%@",
                           [textView.text substringToIndex:range.location],
                           text,
                           [textView.text substringFromIndex:range.location+range.length]];
//    NSLog(@"cacheText = %@", cacheText);
    if (cacheText.length > appStatusMaximumCharacterNumber) {
        textView.text = [cacheText substringToIndex:appStatusMaximumCharacterNumber];
        self.charCountsLabel.text = @"0";
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
//    DLog(@"字符长度=%lu", (unsigned long)textView.text.length);

    self.charCountsLabel.text =
    [NSString stringWithFormat:@"%d", (int)(appStatusMaximumCharacterNumber-textView.text.length)];
}

// 清除文本
- (void)clearTextView:(id)sender {
    self.statusTextView.text = nil;
    self.charCountsLabel.text =
    [NSString stringWithFormat:@"%ld", (long)appStatusMaximumCharacterNumber];
}

#pragma mark - actions

// 取消
- (void)leftBarButtonItemClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// 发送
- (void)rightBarButtonItemClicked:(id)sender {
    DLog(@"发送");
    
    AppHTTPSessionManager *httpSessionManager = [AppHTTPSessionManager sharedHTTPManager];
    
    MainNavigationController *mainNavigationController = [MainNavigationController sharedMainNavigationController];
    
    NSAssert(mainNavigationController.userInfo.userID.length > 0, @"server error");
    
    WeakSelf(weakSelf);
    [httpSessionManager publishMomentWithUserID:mainNavigationController.userInfo.userID
                                        content:self.statusTextView.text
                                      imageURLs:@""
                                        success:^(NSDictionary *resultDic) {
                                            DLog("添加成功：%@", resultDic);
                                            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
                                        }
                                        failure:^(NSError *error) {
                                            [SVProgressHUD showInfoWithStatus:error.localizedDescription];
                                        }];
}

#pragma mark - UploadImageViewDelegate

- (void)didClickedUploadImageView:(UploadImageView *)uploadImageView {
    DLog(@"点击 - 上传图片");
}

- (void)didLongPressedUploadImageView:(UploadImageView *)uploadImageView {
    DLog(@"长按 - 上传图片");
}

@end
