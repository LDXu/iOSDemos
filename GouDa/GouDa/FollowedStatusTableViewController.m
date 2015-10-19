//
//  FollowedStatusTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "FollowedStatusTableViewController.h"
#import "AppHTTPSessionManager+Quan.h"
#import "MainNavigationController.h"

@interface FollowedStatusTableViewController ()

@end

@implementation FollowedStatusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainNavigationController *mainNavigationController = [MainNavigationController sharedMainNavigationController];

    AppHTTPSessionManager *httpManager = [AppHTTPSessionManager sharedHTTPManager];
    [httpManager followedStatusWithUserID:mainNavigationController.userInfo.userID
                                pageIndex:0
                             countPerPage:100
                                  success:^(NSDictionary *resultDic) {
                                      
                                  }
                                  failure:^(NSError *error) {
                                      
                                  }];
}

@end
