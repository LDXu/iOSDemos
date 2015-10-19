//
//  QuanNavigationController.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "QuanNavigationController.h"
#import "QuanPageViewController.h"

@implementation QuanNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QuanPageViewController *pageViewController =
    [[QuanPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                    options:nil];
    
    [self pushViewController:pageViewController animated:NO];
}

@end
