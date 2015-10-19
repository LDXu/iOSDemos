//
//  MainMessagesViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/12.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "MainMessagesViewController.h"

#define kViewControllerMarginLeft     (50.f)

@interface MainMessagesViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MainMessagesViewController

- (void)initViews {
    self.view.opaque = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    self.titleLabel = ({
        UILabel *label =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 20,
                                                  self.view.frame.size.width-kViewControllerMarginLeft,
                                                  navigationBarHeight)];
        label.text = @"24条未读信息";
        label.font = [UIFont systemFontOfSize:18.f];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor appFontBrownColor];
        label;
    });
    [self.view addSubview:self.titleLabel];

    // 分割线
#define kTopLineHeight  (0.5f)
    UIView *topSeperatorLine = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                        statusBarHeight+navigationBarHeight,
                                                                        self.view.frame.size.width,
                                                                        kTopLineHeight)];
    topSeperatorLine.backgroundColor = [UIColor appNavigationBarBottomColor];
    [self.view addSubview:topSeperatorLine];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 80, 30)];
    view1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120, 80, 80, 30)];
    view2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(220, 80, 80, 30)];
    view3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view3];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(320, 80, 80, 30)];
    view4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view4];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

@end
