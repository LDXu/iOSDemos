//
//  FuckViewController.m
//  REFrostedViewControllerExample
//
//  Created by 张威 on 15/9/24.
//  Copyright © 2015年 Roman Efimov. All rights reserved.
//

#import "FuckViewController.h"
#import "REFrostedViewController.h"

@interface FuckViewController()

@end


@implementation FuckViewController {
    UIView *_bgView;
    UIView *_whiteView;
    UIButton *_closeButton;
}

- (void)initViews {
//    self.view.opaque = NO;
//    self.view.backgroundColor = [UIColor clearColor];
#define kCloseButtonSideLength (32.f)
#define kBgViewMarginLeft      (30.f)
#define kBgViewMarginRight     kBgViewMarginLeft
    _bgView =
    [[UIView alloc] initWithFrame:CGRectMake(kBgViewMarginLeft, 80,
                                             self.view.frame.size.width-kBgViewMarginLeft -
                                             kBgViewMarginRight + kCloseButtonSideLength/2,
                                             self.view.frame.size.height-160)];
    _bgView.opaque = NO;
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    
    _whiteView =
    [[UIView alloc] initWithFrame:CGRectMake(0, kCloseButtonSideLength/2,
                                             _bgView.frame.size.width-kCloseButtonSideLength/2,
                                             _bgView.frame.size.height-kCloseButtonSideLength/2)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    _whiteView.layer.cornerRadius = 8.f;
    [_bgView addSubview:_whiteView];
    
    _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(_bgView.frame.size.width-kCloseButtonSideLength,
                                                              0, kCloseButtonSideLength, kCloseButtonSideLength)];
    [_closeButton setImage:[UIImage imageNamed:@"close_gouda"] forState:UIControlStateNormal];
//    _closeButton.layer.cornerRadius = kCloseButtonSideLength/2;
    _closeButton.layer.masksToBounds = YES;
    [_closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_closeButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

- (void)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame = CGRectMake(30, 80, self.view.frame.size.width-45, self.view.frame.size.height-160);
    } completion:nil];
}
 */

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

@end
