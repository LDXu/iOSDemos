//
//  GDStatusBottomView.h
//  GouDa
//
//  Created by 张威 on 15/10/16.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GDStatusBottomViewDelegate;

@interface GDStatusBottomView : UIView

@property (nonatomic, weak) id<GDStatusBottomViewDelegate> delegate;

@property (nonatomic, copy) NSString *timeInfo;
// 点赞数
@property (nonatomic, assign) NSUInteger likes;
// 已被点赞
@property (nonatomic, assign) BOOL likeSelected;
// 评论数
@property (nonatomic, assign) NSUInteger replies;

- (void)prepareForReuse;

@end

@protocol GDStatusBottomViewDelegate <NSObject>

- (void)replyButtonDidClicked:(GDStatusBottomView *)view;
- (void)likeButtonDidSelected:(GDStatusBottomView *)view;

@end
