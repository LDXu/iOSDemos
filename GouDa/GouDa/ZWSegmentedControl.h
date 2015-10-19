//
//  ZWSegmentedControl.h
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/18.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWSegmentedControl : UIView

@property (nonatomic, strong) UISegmentedControl *sg;

- (instancetype)init __attribute__((unavailable("init not available")));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

// items should be NSStrings
- (instancetype)initWithItems:(NSArray *)items;

// default is -1
@property(nonatomic) NSInteger selectedSegmentIndex;

@property(nonatomic, strong) UIColor *tintColor;

// 圆角
@property (nonatomic, assign) CGFloat cornerRadius;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end