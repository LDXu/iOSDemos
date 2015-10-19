//
//  MainTabBarController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "MainTabBarController.h"
#import "DaNavigationController.h"
#import "QuanNavigationController.h"
#import "ZhiNavigationController.h"
#import "MineNavigationController.h"

#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.translucent = YES;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    DaNavigationController *daVC = [[DaNavigationController alloc] init];
    UIImage *tabBarImage1         = [UIImage imageNamed:@"gouda.png"];
    UIImage *tabBarSelectedImage1 = [UIImage imageNamed:@"gouda_Selected.png"];
    tabBarImage1                  = [tabBarImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarSelectedImage1          = [tabBarSelectedImage1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    daVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"狗搭"
                                                    image:tabBarImage1
                                            selectedImage:tabBarSelectedImage1];
    
    QuanNavigationController *quanVC = [[QuanNavigationController alloc] init];
    UIImage *tabBarImage2         = [UIImage imageNamed:@"gouquan.png"];
    UIImage *tabBarSelectedImage2 = [UIImage imageNamed:@"gouquan_Selected.png"];
    tabBarImage2                  = [tabBarImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarSelectedImage2          = [tabBarSelectedImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    quanVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"狗圈"
                                                      image:tabBarImage2
                                              selectedImage:tabBarSelectedImage2];
    
    ZhiNavigationController *zhiVC = [[ZhiNavigationController alloc] init];
    UIImage *tabBarImage3         = [UIImage imageNamed:@"gouzhi.png"];
    UIImage *tabBarSelectedImage3 = [UIImage imageNamed:@"gouzhi_Selected.png"];
    tabBarImage3                  = [tabBarImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarSelectedImage3          = [tabBarSelectedImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    zhiVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"狗知"
                                                     image:tabBarImage3
                                             selectedImage:tabBarSelectedImage3];
    
    MineNavigationController *mineVC = [[MineNavigationController alloc] init];
    UIImage *tabBarImage4         = [UIImage imageNamed:@"me.png"];
    UIImage *tabBarSelectedImage4 = [UIImage imageNamed:@"me_Selected.png"];
    tabBarImage4                  = [tabBarImage4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarSelectedImage4          = [tabBarSelectedImage4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                      image:tabBarImage4
                                              selectedImage:tabBarSelectedImage4];
    
    
    self.viewControllers = @[daVC, quanVC, zhiVC, mineVC];
}

static MainTabBarController *_sharedMainTabBarController;

- (instancetype)init {
    if (_sharedMainTabBarController == nil) {
        _sharedMainTabBarController = [super init];
    }
    return _sharedMainTabBarController;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return appCommonStatusBarStyle;
}

+ (instancetype)sharedMainTabBarController {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedMainTabBarController = [[MainTabBarController alloc] init];
    });
    
    return _sharedMainTabBarController;
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

@end
