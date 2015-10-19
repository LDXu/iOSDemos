//
//  CityWideTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "CityWideTableViewController.h"
#import "AppHTTPSessionManager+Quan.h"
#import "MainNavigationController.h"

@interface CityWideTableViewController ()

@end

@implementation CityWideTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainNavigationController *mainNavigationController = [MainNavigationController sharedMainNavigationController];

    AppHTTPSessionManager *httpManager = [AppHTTPSessionManager sharedHTTPManager];
    [httpManager cityWideStatusWithUserID:mainNavigationController.userInfo.userID
                                   cityID:mainNavigationController.userInfo.cityID
                                pageIndex:0
                             countPerPage:100
                                  success:^(NSDictionary *resultDic) {
                                    
                                  }
                                  failure:^(NSError *error) {
                                      
                                  }];
}

@end
