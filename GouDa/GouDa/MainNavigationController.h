//
//  MainNavigationController.h
//  GouDa
//
//  Created by 张威 on 15/10/12.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UserInfo.h"

@interface MainNavigationController : BaseNavigationController

extern NSString *const UserInfoChangedNotificaiton;

+ (instancetype)sharedMainNavigationController;

// show login view controller
- (void)showLoginViewController;

// show tab bar controller
- (void)showTabBarController;

//@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, strong, readonly) UserInfo *userInfo;

- (void)updateUserInfoWithDict:(NSDictionary *)dict;
//- (void)updateUserID:(NSString *)userID;

@end
