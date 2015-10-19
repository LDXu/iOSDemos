//
//  MineNavigationController.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "MineNavigationController.h"
#import "MineTableViewController.h"

@implementation MineNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MineTableViewController *rootVC = [[MineTableViewController alloc] init];
    [self pushViewController:rootVC animated:NO];
}

@end
