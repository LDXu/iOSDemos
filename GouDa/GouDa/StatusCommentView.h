//
//  StatusCommentView.h
//  GouDa
//
//  Created by 张威 on 15/9/27.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, StatusCommentViewStyle)
{
    StatusCommentViewStyleFirst = 1,
    StatusCommentViewStyleCommon = 2,
};

@interface StatusCommentView : UIView

- (instancetype)initWithStyle:(StatusCommentViewStyle)style;
- (instancetype)init __attribute__((unavailable("init not available")));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

@property (nonatomic, assign) StatusCommentViewStyle style;
@property (nonatomic, assign) CGFloat arrowOffsetX;

@property (nonatomic, copy) NSString *nickString;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, assign) BOOL showTopLine;

- (void)prepareForReuse;

@end
