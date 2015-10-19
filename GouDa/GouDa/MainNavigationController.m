//
//  MainNavigationController.m
//  GouDa
//
//  Created by 张威 on 15/10/12.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "MainNavigationController.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"

@interface MainNavigationController ()

@property (nonatomic, strong) LoginViewController *loginViewController;
@property (nonatomic, strong) MainTabBarController *mainTabBarController;

//@property (nonatomic, copy) NSString *userID;
@property (nonatomic, strong) UserInfo *userInfo;

@end

NSString *const UserInfoChangedNotificaiton = @"UserInfoChangedNotificaiton";

@implementation MainNavigationController

static MainNavigationController *_sharedMainNavigationController = nil;
static dispatch_once_t onceToken;

- (instancetype)init {
    dispatch_once(&onceToken, ^{
        _sharedMainNavigationController = [super init];
    });
    return _sharedMainNavigationController;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    dispatch_once(&onceToken, ^{
        _sharedMainNavigationController = [super initWithRootViewController:rootViewController];
    });
    return _sharedMainNavigationController;
}

+ (instancetype)sharedMainNavigationController {
    return [[MainNavigationController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.translucent = YES;
}

// show login view controller
- (void)showLoginViewController {
    self.navigationBar.hidden = YES;
    [self pushViewController:self.loginViewController animated:NO];
}

// show tab bar controller
- (void)showTabBarController {
    self.navigationBar.hidden = YES;
    [self pushViewController:[MainTabBarController sharedMainTabBarController] animated:NO];
}

// getter
- (LoginViewController *)loginViewController {
    if (_loginViewController == nil) {
        _loginViewController = [[LoginViewController alloc] init];
    }
    return _loginViewController;
}

/*
- (void)updateUserID:(NSString *)userID {
    if ([_userID isEqualToString:userID]) {
        return;
    }
    
    _userID = [userID copy];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserIDChangedNotificaiton object:nil];
}
*/

- (void)updateUserInfoWithDict:(NSDictionary *)dict {
    self.userInfo = [[UserInfo alloc] initWithDictionary:dict];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserInfoChangedNotificaiton object:nil];
}

@end
