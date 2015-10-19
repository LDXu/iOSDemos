//
//  Configuration.h
//  lzseller
//
//  Created by 张威 on 15/6/18.
//  Copyright (c) 2015年 no one. All rights reserved.
//

#ifndef APP_Configuration_h
#define APP_Configuration_h

// 调试，打印
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

// quickly setup a weak self
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self
// quickly setup a strong self
#define StrongSelf(strongSelf)  __strong __typeof(weakSelf)strongSelf = weakSelf

// HTTP API Base URL
static NSString * const AppHTTPAPIBaseURLString = @"http://120.25.125.233/Api/";

#define SOURCE_BOSS         @"761f0a58-3419-45fb-ae58-879d83110d7d"
#define SOURCE_BRAINPOWER   @"caadf8fa-0c9d-467a-92c0-18e18395aa3b"

#define BaiDu_Map_Boss_Key  @"qijtuixDFX5bb8cE56lYpWOY"


#define APP_PROPERTYLIST_FILENAME @"appGeneric.plist"
//
#define APP_LASTLOGIN_USER_KEYCHAIN @"APP_LASTLOGIN_USER"

static CGFloat const appCommonCornerRadius = 5.f;
static CGFloat const appCommonTableViewCellLeftPadding = 20.f;

// 狗圈发布「新状态」最多字数
static int const appStatusMaximumCharacterNumber = 140;

// quickly get mainNavigationController
#define MainNavVC(mainNavigationController) \
MainNavigationController *mainNavigationController = [MainNavigationController sharedMainNavigationController];

#define statusBarHeight         (20.0)
#define navigationBarHeight     (44.0)
#define tabBarHeight            (49.0)

#define tableFooterViewHeight   (20.f)

#define leftBarButtonItemLeftMargin     (10.f)
#define rightBarButtonItemRightMargin   (10.f)

#define kNavigationSegmentControlWidthWithTwoItems   (140.f)
#define kNavigationSegmentControlWidthWithThreeItems (210.f)
#define kNavigationSegmentControlHeight              (30.f)

// 屏幕尺寸
#define mainScreenWidth [UIScreen mainScreen].bounds.size.width
#define mainScreenHeight [UIScreen mainScreen].bounds.size.height

extern NSString * const AppLoginSucceedNotification;

static UIStatusBarStyle appCommonStatusBarStyle = UIStatusBarStyleDefault;

typedef NS_ENUM(NSUInteger, ZWInputViewType) {
    // 普通，即「键盘输入」
    ZWInputViewTypeNormal = 0,
    // 「文本输入」
    ZWInputViewTypeText,
    // 「表情输入」
    ZWInputViewTypeEmotion,
    // 「多媒体」
    ZWInputViewTypeMedia,
};

// custom response domain
static NSString *AppHTTPResponseDomainDefault = @"AppHTTPResponseDomainDefault";
// 错误码
static NSInteger AppHTTPResponseCodeDefaultError = 1;
// 正确码
static NSInteger AppHTTPResponseCodeSuccess = 0;

static NSString *AppDeviceDescription = @"ios";


#endif
