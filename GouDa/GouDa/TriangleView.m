//
//  TriangleView.m
//  GouDa
//
//  Created by 张威 on 15/10/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView

#define kArrowHeight           (10.f)

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    // Drawing code
    //设置线条颜色
    [[UIColor clearColor] set];
    
    UIBezierPath *viewPath = [UIBezierPath bezierPath];
    [viewPath moveToPoint:CGPointMake(self.arrowOffsetX-kArrowHeight, kArrowHeight)]; // 左下角
    
    [viewPath addLineToPoint:CGPointMake(self.arrowOffsetX, 0)];    // 上顶点
    [viewPath addLineToPoint:CGPointMake(self.arrowOffsetX+kArrowHeight, kArrowHeight)];    // 右下角
    
    //填充颜色
    [[UIColor appSeparatorGrayColor3] setFill];
    [viewPath fill];
    [viewPath closePath];
    [viewPath stroke];
}

+ (CGFloat)fixedHeight {
    return kArrowHeight;
}

@end
