//
//  ZhiNavigationController.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ZhiNavigationController.h"
#import "ZhiPageViewController.h"
#import "ZhiTableViewController.h"

@implementation ZhiNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent  = YES;
    
    /*
    ZhiPageViewController *pageViewController =
    [[ZhiPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                   options:nil];
     */
    ZhiTableViewController *VC = [[ZhiTableViewController alloc] init];
    [self pushViewController:VC animated:NO];
}

@end
