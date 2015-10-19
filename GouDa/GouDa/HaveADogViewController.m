//
//  HaveADogViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/14.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "HaveADogViewController.h"
#import "UIView+App.h"
#import "GouInfoViewController.h"

@interface HaveADogViewController ()

@end

@implementation HaveADogViewController

- (void)initViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationItem.rightBarButtonItem =
    [UIView barButtonItemWithTitle:@"跳过" target:self action:@selector(rightBarButtonItemClicked:)];
    
    UILabel *doYouHaveADogLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.text          = @"您现在有狗狗吗？";
        label.font          = [UIFont systemFontOfSize:24.f];
        label.textColor     = [UIColor appFontGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    [self.view addSubview:doYouHaveADogLabel];
    
    UIButton *button1 = ({
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"暂时没有" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor appFontBrownColor]  forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18.f];
        button.backgroundColor = [UIColor appLightYellowColor];
        [button addTarget:self
                   action:@selector(haveNoDog:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:button1];
    
    UIButton *button2 = ({
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"有狗狗" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor appFontBrownColor]  forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18.f];
        button.backgroundColor = [UIColor appLightYellowColor];
        [button addTarget:self
                   action:@selector(haveADog:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:button2];
    
    UIEdgeInsets viewEdgeInsets = UIEdgeInsetsMake(100, 20, 100, 20);
    UIView *superView = self.view;
    
    [doYouHaveADogLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).insets(viewEdgeInsets);
        make.right.equalTo(superView).insets(viewEdgeInsets);
        make.top.equalTo(superView).insets(viewEdgeInsets);
        make.height.equalTo(@80);
    }];
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).insets(viewEdgeInsets);
        make.right.equalTo(superView).insets(viewEdgeInsets);
        make.top.equalTo(doYouHaveADogLabel.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    button1.layer.cornerRadius = appCommonCornerRadius;
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).insets(viewEdgeInsets);
        make.right.equalTo(superView).insets(viewEdgeInsets);
        make.top.equalTo(button1.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    button2.layer.cornerRadius = appCommonCornerRadius;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    self.title = @"狗狗情况";
}

#pragma mark - actions

- (void)rightBarButtonItemClicked:(id)sender {
    DLog(@"跳过");
}

- (void)haveNoDog:(UIButton *)sender {
    
}

- (void)haveADog:(UIButton *)sender {
    GouInfoViewController *VC = [[GouInfoViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
