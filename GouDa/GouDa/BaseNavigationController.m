//
//  BaseNavigationController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 配置navigation bar外观开始 */
    self.navigationBar.translucent  = NO;
    // 文字颜色
    self.navigationBar.tintColor    = [UIColor appFontBrownColor];
    // navigation bar颜色
    self.navigationBar.barTintColor = [UIColor appLightYellowColor];
    
    UIFont *titleFont = [UIFont appViewControllerTitleFont];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor appBrownColor],
                                                NSForegroundColorAttributeName,
                                                titleFont,
                                                NSFontAttributeName,
                                                nil]];
    
    // 掩盖navigationBar底部的线条
//    self.navigationBar.layer.borderWidth = 1.f;
//    self.navigationBar.layer.borderColor = [[UIColor appLightYellowColor] CGColor];
    /* 配置navigation bar外观结束 */
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return appCommonStatusBarStyle;
}

@end
