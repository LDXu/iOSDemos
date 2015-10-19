//
//  ZWSocialSharedView.h
//  GouDa
//
//  Created by 张威 on 15/9/25.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZWSocialSharedViewDelegate;

@interface ZWSocialSharedView : UIView

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("init not available")));

@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, strong) UIColor *underlyingColor;

@property (nonatomic, weak) id<ZWSocialSharedViewDelegate> delegate;

- (void)show;

@end

@protocol ZWSocialSharedViewDelegate <NSObject>

- (void)socialSharedView:(ZWSocialSharedView *)socialSharedView didTappedAtIndex:(NSUInteger)index;

@end
