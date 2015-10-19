//
//  BasePageViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "BasePageViewController.h"

@implementation BasePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor appViewControllerGrayBackgroundColor];
    self.navigationItem.backBarButtonItem.title = @"返回";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return appCommonStatusBarStyle;
}


@end
