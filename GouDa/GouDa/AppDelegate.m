//
//  AppDelegate.m
//  GouDa
//
//  Created by 张威 on 15/9/18.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import <MAMapKit/MAMapKit.h>
//#import "MainTabBarController.h"
//#import "MainMessagesViewController.h"
#import "REFrostedViewController.h"
#import "MainNavigationController.h"
#import "WelcomeViewController.h"

@interface AppDelegate () <REFrostedViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    /*
    // menu view controller
    MainMessagesViewController *menuController = [[MainMessagesViewController alloc] init];
    
    // tab bar controller
    MainTabBarController *tabBarController = [MainTabBarController sharedMainTabBarController];
    
    // frosted view controller
    REFrostedViewController *frostedViewController =
    [[REFrostedViewController alloc] initWithContentViewController:tabBarController
                                                menuViewController:menuController];
    
    frostedViewController.direction               = REFrostedViewControllerDirectionRight;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur                = YES;
    frostedViewController.panGestureEnabled       = NO;
    frostedViewController.backgroundFadeAmount    = 0.1;
     */
    
    WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] init];
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:welcomeViewController];

    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //自定义返回按钮
//    UIImage *backButtonImage =
    //[UIImage imageNamed:@"return_brown"];
//    [[UIImage imageNamed:@"return_brown"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
//                                                      forState:UIControlStateNormal
//                                                    barMetrics:UIBarMetricsDefault];
    // 将返回按钮的文字position设置不在屏幕上显示
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, NSIntegerMin)
//                                                         forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *barButtonItemTextAttrs = @{NSForegroundColorAttributeName: [UIColor appFontBrownColor],
                                             NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                             };
    [[UIBarButtonItem appearance] setTitleTextAttributes:barButtonItemTextAttrs forState:UIControlStateNormal];
    
    // 配置UITabBarItem
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor appFontGrayColor]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor appFontGrayColor]}
                                             forState:UIControlStateSelected];
    
    // 配置SVProgressHUD
    [SVProgressHUD setBackgroundColor:[[UIColor alloc] initWithRed:190/255.f green:160/255.f blue:118/255.f alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [[UIButton appearance] setTitleColor:[UIColor appFontBrownColor] forState:UIControlStateNormal];
    [[UITextField appearance] setTintColor:[UIColor appFontBrownColor]];
    [[UITextView appearance] setTintColor:[UIColor appFontBrownColor]];
    
    // 配置地图
    // 高度地图
    [MAMapServices sharedServices].apiKey = @"3e56f5aab80ee3463090bed0cea4a992";
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer {
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willShowMenuViewController:(UIViewController *)menuViewController {
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didShowMenuViewController:(UIViewController *)menuViewController {
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController {
    
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didHideMenuViewController:(UIViewController *)menuViewController {
    
}


@end
