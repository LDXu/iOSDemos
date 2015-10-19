//
//  ZWSocialView.h
//  GouDa
//
//  Created by 张威 on 15/9/25.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZWSocialViewDelegate;

@interface ZWSocialView : UIControl

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, weak) id<ZWSocialViewDelegate> delegate;

@end

@protocol ZWSocialViewDelegate <NSObject>

- (void)didTappedSocialView:(ZWSocialView *)socialView;

@end
