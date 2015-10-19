//
//  GDStatusPublisherInfoView.h
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GDStatusPublisherInfoViewDelegate;

@interface GDStatusPublisherInfoView : UIView

@property (nonatomic, weak) id<GDStatusPublisherInfoViewDelegate> delegate;

@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *distanceString;
@property (nonatomic, assign) BOOL showOperationButton;

- (void)prepareForReuse;

@end

@protocol GDStatusPublisherInfoViewDelegate <NSObject>

- (void)moreOperationButtonClicked:(UIButton *)sender;

@end
