//
//  MapSlideMapSegmentController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "MapSlideMapSegmentController.h"
#import "ZWSegmentedControl.h"
#import "FilterTableviewController.h"
#import "UIView+App.h"
#import "DogWalkingViewController.h"

@interface MapSlideMapSegmentController () <JYSlideSegmentDelegate>

@end

@implementation MapSlideMapSegmentController {
    UIViewController *_childrenVC1;
    UIViewController *_childrenVC2;
    UIViewController *_childrenVC3;
}

- (instancetype)init {

    _childrenVC1 = [[DogWalkingViewController alloc] init];
    _childrenVC1.title = @"遛狗";
    
    _childrenVC2 = [[UIViewController alloc] init];
    _childrenVC2.view.backgroundColor = [UIColor greenColor];
    _childrenVC2.title = @"相亲";
    
    _childrenVC3 = [[UIViewController alloc] init];
    _childrenVC3.view.backgroundColor = [UIColor blueColor];
    _childrenVC3.title = @"寄养";
    
    self = [super initWithViewControllers:@[_childrenVC1, _childrenVC2, _childrenVC3]];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)initViews {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self initViews];
    
    self.indicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - target-action

- (void)leftBarButtonItemClicked:(id)sender {
    DLog(@"筛选");
    FilterTableviewController *VC = [[FilterTableviewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)rightBarButtonItemClicked:(id)sender {
    DLog(@"查看信息");
}

- (void)segmentedControlClicked:(ZWSegmentedControl *)sender {
    DLog(@"sender.selectedSegmentIndex = %ld", (long)sender.selectedSegmentIndex);
}

@end
