//
//  ZWCommentInputView.h
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/28.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@protocol ZWCommentInputViewDelegate;

@interface ZWCommentInputView : UIView

- (instancetype)init __attribute__((unavailable("init not available")));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

- (instancetype)initWithOrigin:(CGPoint)origin;

@property (nonatomic, weak) id<ZWCommentInputViewDelegate> delegate;


@property (nonatomic, strong, readonly) HPGrowingTextView *inputView;

- (void)prepareForReuse;

+ (CGFloat)initalHeight;

@end

@protocol ZWCommentInputViewDelegate <NSObject>

- (BOOL)inputViewShouldReturn:(ZWCommentInputView *)inputView;

@optional
- (void)inputView:(ZWCommentInputView *)inputView didSendEmotionStateChanged:(BOOL)selected;

@end
