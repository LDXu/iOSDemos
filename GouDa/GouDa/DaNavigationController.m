//
//  DaNavigationController.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "DaNavigationController.h"
#import "DaPageViewController.h"

@implementation DaNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DaPageViewController *pageViewController =
    [[DaPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                  options:nil];
    
    [self pushViewController:pageViewController animated:NO];
}

@end
