//
//  MainTabBarController.h
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController

/*
- (instancetype)init __attribute__((unavailable("init not available")));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder not available")));
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
__attribute__((unavailable("initWithCoder not available")));
 */


+ (instancetype)sharedMainTabBarController;

- (void)showMenu;

@end
