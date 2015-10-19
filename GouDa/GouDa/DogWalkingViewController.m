//
//  DogWalkingViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/24.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "DogWalkingViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "REFrostedViewController.h"

@interface DogWalkingViewController () <MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@end


@implementation DogWalkingViewController

- (void)loadView {
    self.view =
    [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth,
                                             mainScreenHeight-navigationBarHeight-statusBarHeight)];
}

- (void)initViews {
    self.mapView =
    [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),
                                                CGRectGetHeight(self.view.bounds))];
    self.mapView.backgroundColor = [UIColor appViewControllerGrayBackgroundColor];
    self.mapView.showsCompass    = NO;
    self.mapView.showsScale      = NO;
    [self.view addSubview:self.mapView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    self.mapView.delegate = nil;
    [super viewDidDisappear:animated];
}

@end
