//
//  ZWSocialSharedView.m
//  GouDa
//
//  Created by 张威 on 15/9/25.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ZWSocialSharedView.h"
#import "ZWSocialView.h"

@interface ZWSocialSharedView () <ZWSocialViewDelegate>

@property (nonatomic, strong) UIControl *overlayView;
@property (nonatomic, assign) BOOL isAnimation;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *socialViews;

@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation ZWSocialSharedView

#define kTitleLabelHeight           (40.f)

#define kSocialViewWidth            (61.f)
#define kSocialViewHeight           (80.f)
#define kSocialViewInteritemSpacing (10.f)
#define kSocialViewCount            (6)

#define kSeperatorLineHeight        (1.f)

#define kBottomButtonHeight         (44.f)

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    _animationDuration   = 0.35;
    _isAnimation         = false;
    _underlyingColor     = [[UIColor alloc] initWithWhite:0.0 alpha:0.2];
    
    CGFloat offsetY = 0.f;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, offsetY, self.frame.size.width, kTitleLabelHeight)];
    _titleLabel.text = @"分享";
    _titleLabel.font = [UIFont systemFontOfSize:14.f];
    _titleLabel.textColor = [UIColor appGrayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    offsetY += kTitleLabelHeight;
    
    _socialViews = [NSMutableArray arrayWithCapacity:kSocialViewCount];
    NSArray *titles = @[@"微信朋友圈", @"微信好友", @"QQ空间", @"QQ好友", @"新浪微博", @"复制链接"];
    NSArray *images = @[
                        [UIImage imageNamed:@"social_pengyouquan.png"],
                        [UIImage imageNamed:@"social_weixin.png"],
                        [UIImage imageNamed:@"social_qqzone.png"],
                        [UIImage imageNamed:@"social_qq.png"],
                        [UIImage imageNamed:@"social_weibo.png"],
                        [UIImage imageNamed:@"social_copy.png"]
                        ];
    CGFloat socialViewLineSpacing = floorf((self.frame.size.width - kSocialViewWidth * 4) / 5);
    for (int i = 0; i < kSocialViewCount; ++i) {
        if (i % 4 == 0) {
            offsetY += (kSocialViewHeight + kSocialViewInteritemSpacing) * (i/4);
        }
        CGFloat offsetX = (i%4) * kSocialViewWidth + ((i%4)+1) * socialViewLineSpacing;
        ZWSocialView *socialView =
        [[ZWSocialView alloc] initWithFrame:CGRectMake(offsetX, offsetY,
                                                       kSocialViewWidth, kSocialViewHeight)];
        socialView.delegate = self;
        socialView.title = titles[i];
        socialView.icon = images[i];
        [_socialViews addObject:socialView];
        [self addSubview:socialView];
    }
    
    if (_socialViews.count > 0) {
        offsetY += (kSocialViewHeight + kSocialViewInteritemSpacing);
    }
    
    UIView *seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, self.frame.size.width, kSeperatorLineHeight)];
    seperatorLine.backgroundColor = [UIColor appLightGrayColor];
    [self addSubview:seperatorLine];
    
    offsetY += kSeperatorLineHeight;
    self.cancelButton =
    [[UIButton alloc] initWithFrame:CGRectMake(0, offsetY,
                                               self.frame.size.width, self.frame.size.height - offsetY)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor appGrayColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [self.cancelButton addTarget:self action:@selector(cancelButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
}

- (instancetype)init {
    CGFloat viewHeight = 0.f;
    viewHeight += kTitleLabelHeight;
    viewHeight += (kSocialViewHeight + kSocialViewInteritemSpacing) * ((kSocialViewCount + 3) / 4);
    viewHeight += kSeperatorLineHeight;
    viewHeight += kBottomButtonHeight;
    self = [super initWithFrame:CGRectMake(0, 0, mainScreenWidth, viewHeight)];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - overlay view

- (UIControl *)overlayView {
    if (_overlayView == nil) {
        _overlayView                 = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayView.backgroundColor = _underlyingColor;
        _overlayView.hidden          = YES;
        _overlayView.alpha           = 0.f;
        [_overlayView addTarget:self
                         action:@selector(overlayViewDidReceiveTouchEvent:forEvent:)
               forControlEvents:UIControlEventTouchDown];
    }
    return _overlayView;
}

#pragma mark - target-actions
- (void)overlayViewDidReceiveTouchEvent:(id)sender forEvent:(UIEvent *)event {
    if (self.isAnimation) {
        return;
    }
    [self dismissWithAnimation:YES];
}

#pragma mark - Master show/dismiss methods

- (void)show {
    
    self.overlayView.hidden = YES;
    self.overlayView.alpha = 0.f;
    
    if (!self.overlayView.superview) {
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:self.overlayView];
                break;
            }
        }
    } else {
        DLog(@"some unexpected thing happend...some unexpected thing happend...");
        // Ensure that overlay will be exactly on top of rootViewController (which may be changed during runtime).
        [self.overlayView.superview bringSubviewToFront:self.overlayView];
    }
    
    self.frame = CGRectMake(0, self.overlayView.frame.size.height, self.frame.size.width, self.frame.size.height);
    if(!self.superview) {
        [self.overlayView addSubview:self];
    }
    
    self.overlayView.hidden = NO;
    self.isAnimation        = true;
    WeakSelf(weakSelf);
    [UIView animateWithDuration:_animationDuration
                     animations:^{
                         weakSelf.frame = CGRectMake(0, self.overlayView.frame.size.height-self.frame.size.height,
                                                     self.frame.size.width, self.frame.size.height);
                         weakSelf.overlayView.alpha = 1.f;
                     }
                     completion:^(BOOL finished) {
                         _isAnimation = false;
                     }];
}

- (void)dismiss {
    [self dismissWithAnimation:YES];
}

- (void)dismissWithAnimation:(BOOL)animatation {
    self.isAnimation = true;
    
    WeakSelf(weakSelf);
    [UIView animateWithDuration:_animationDuration
                     animations:^{
                         weakSelf.overlayView.alpha = 0.f;
                         weakSelf.frame = CGRectMake(0, weakSelf.overlayView.frame.size.height,
                                                     weakSelf.frame.size.width, weakSelf.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         weakSelf.overlayView.hidden = YES;
                         [weakSelf removeFromSuperview];
                         [weakSelf.overlayView removeFromSuperview];
                         weakSelf.isAnimation = false;
                     }];
}

#pragma mark - ZWSocialViewDelegate

- (void)didTappedSocialView:(ZWSocialView *)socialView {
    DLog(@"%@ did tapped", socialView.title);
    if ([self.delegate respondsToSelector:@selector(socialSharedView:didTappedAtIndex:)]) {
        NSUInteger index = [self.socialViews indexOfObject:socialView];
        [self.delegate socialSharedView:self didTappedAtIndex:index];
    }
}

#pragma mark - actions

// 取消
- (void)cancelButtonDidClicked:(id)sender {
    [self dismiss];
}

@end
