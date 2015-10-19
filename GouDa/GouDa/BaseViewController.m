//
//  BaseViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"返回";
    
    self.view.backgroundColor = [UIColor appViewControllerGrayBackgroundColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return appCommonStatusBarStyle;
}

@end
