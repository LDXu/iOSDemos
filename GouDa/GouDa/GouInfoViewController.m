//
//  GouInfoViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/14.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "GouInfoViewController.h"

@interface GouInfoViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *inputBgView;

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UITextField *nickTextField;
@property (nonatomic, strong) UITextField *ageTextField;
@property (nonatomic, strong) UITextField *genderTextField;
@property (nonatomic, strong) UITextField *categoryTextField;

@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation GouInfoViewController

- (void)initViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.inputBgView                 = [[UIView alloc] init];
    //    self.inputBgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.inputBgView];

    // avatar
    self.avatarImageView                 = [[UIImageView alloc] init];
    self.avatarImageView.backgroundColor = [UIColor redColor];
    [self.inputBgView addSubview:self.avatarImageView];
    
    // nick
    self.nickTextField = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.borderStyle  = UITextBorderStyleNone;
        textField.delegate     = self;
        textField.placeholder  = @"填写狗狗昵称";
        textField.font         = [UIFont systemFontOfSize:16.f];
        textField.textColor    = [UIColor appFontBlackColor];
        textField;
    });
    [self.inputBgView addSubview:self.nickTextField];
    
    UIView *nickTextFieldBottomLine = [[UIView alloc] init];
    nickTextFieldBottomLine.backgroundColor = [UIColor appSeparatorGrayColor2];
    [self.inputBgView addSubview:nickTextFieldBottomLine];
    
    // age
    self.ageTextField = ({
        UITextField *textField    = [[UITextField alloc] init];
        textField.borderStyle     = UITextBorderStyleNone;
        textField.delegate        = self;
        textField.placeholder     = @"选择狗狗年龄";
        textField.font            = [UIFont systemFontOfSize:16.f];
        textField.textColor       = [UIColor appFontBlackColor];
        textField;
    });
    [self.inputBgView addSubview:self.ageTextField];
    
    UIView *ageTextFieldBottomLine = [[UIView alloc] init];
    ageTextFieldBottomLine.backgroundColor = [UIColor appSeparatorGrayColor2];
    [self.inputBgView addSubview:ageTextFieldBottomLine];
    
    // gender
    self.genderTextField = ({
        UITextField *textField    = [[UITextField alloc] init];
        textField.borderStyle     = UITextBorderStyleNone;
        textField.delegate        = self;
        textField.placeholder     = @"选择狗狗性别";
        textField.font            = [UIFont systemFontOfSize:16.f];
        textField.textColor       = [UIColor appFontBlackColor];
        textField;
    });
    [self.inputBgView addSubview:self.genderTextField];
    
    UIView *genderTextFieldBottomLine = [[UIView alloc] init];
    genderTextFieldBottomLine.backgroundColor = [UIColor appSeparatorGrayColor2];
    [self.inputBgView addSubview:genderTextFieldBottomLine];
    
    // category
    self.categoryTextField = ({
        UITextField *textField    = [[UITextField alloc] init];
        textField.borderStyle     = UITextBorderStyleNone;
        textField.delegate        = self;
        textField.placeholder     = @"填写狗狗品种（可不填）";
        textField.font            = [UIFont systemFontOfSize:16.f];
        textField.textColor       = [UIColor appFontBlackColor];
        textField;
    });
    [self.inputBgView addSubview:self.categoryTextField];
    
    UIView *categoryTextFieldBottomLine = [[UIView alloc] init];
    categoryTextFieldBottomLine.backgroundColor = [UIColor appSeparatorGrayColor2];
    [self.inputBgView addSubview:categoryTextFieldBottomLine];
    
    // next step
    self.nextButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor appFontBrownColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18.f];
        button.backgroundColor = [UIColor appLightYellowColor];
        [button addTarget:self
                   action:@selector(nextButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.inputBgView addSubview:self.nextButton];
    
    UIEdgeInsets viewEdgeInsets = UIEdgeInsetsMake(statusBarHeight + navigationBarHeight, 20, 100, 20);
    
    [self.inputBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).insets(viewEdgeInsets);
        make.right.equalTo(self.view).insets(viewEdgeInsets);
        make.top.equalTo(self.view).insets(viewEdgeInsets);
    }];
    
#define kAvatarDiameter     90.f
#define kAvatarMarginTop    20.f
#define kAvatarMarginBottom 50.f    //kAvatarMarginTop
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.inputBgView);
        make.top.equalTo(self.inputBgView).offset(kAvatarMarginTop);
        make.width.equalTo(@kAvatarDiameter);
        make.height.equalTo(@kAvatarDiameter);
    }];
    self.avatarImageView.layer.cornerRadius = kAvatarDiameter / 2;
    
#define kTextFieldHeight    30.f
#define kButtonHeight       40.f
    
    [self.nickTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(kAvatarMarginBottom);
        make.height.equalTo(@kTextFieldHeight);
    }];
    
    [nickTextFieldBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.nickTextField.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.ageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.nickTextField.mas_bottom).offset(10);
        make.height.equalTo(@kTextFieldHeight);
    }];
    
    [ageTextFieldBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.ageTextField.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.genderTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.ageTextField.mas_bottom).offset(10);
        make.height.equalTo(@kTextFieldHeight);
    }];
    
    [genderTextFieldBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.genderTextField.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.categoryTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.genderTextField.mas_bottom).offset(10);
        make.height.equalTo(@kTextFieldHeight);
    }];
    
    [categoryTextFieldBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.categoryTextField.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryTextField.mas_bottom).offset(20);
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.height.equalTo(@kButtonHeight);
        make.bottom.equalTo(self.inputBgView.mas_bottom).offset(-20);
    }];
    self.nextButton.layer.cornerRadius = appCommonCornerRadius;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    // notificate keyboard
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

// 点击self.view其余部分隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)keyBoardWillShow:(NSNotification *)notification {
    
    NSDictionary *keyboardInfo = [notification userInfo];
    
    CGFloat keyboardAnimationDuration = [keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGFloat ty = 0 - kAvatarMarginTop - kAvatarDiameter - statusBarHeight - navigationBarHeight - 5;
    
    [UIView animateWithDuration:keyboardAnimationDuration
                     animations:^{
                         [self.navigationController setNavigationBarHidden:YES animated:YES];
                         self.inputBgView.transform = CGAffineTransformMakeTranslation(0, ty);
                     }];
}

- (void)keyBoardWillHide:(NSNotification *)notification {
    CGFloat keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.inputBgView.transform      = CGAffineTransformIdentity;
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - actions

- (void)nextButtonClicked:(UIButton *)sender {
    DLog(@"下一步");
}

@end
