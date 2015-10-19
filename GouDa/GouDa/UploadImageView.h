//
//  UploadImageView.h
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UploadImageViewDelegate;

@interface UploadImageView : UIControl

@property (nonatomic, strong, readonly) UIImageView *innerImageView;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, weak) id<UploadImageViewDelegate> delegate;

@end

@protocol UploadImageViewDelegate <NSObject>

- (void)didClickedUploadImageView:(UploadImageView *)uploadImageView;
- (void)didLongPressedUploadImageView:(UploadImageView *)uploadImageView;

@end