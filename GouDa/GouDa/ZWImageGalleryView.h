//
//  ZWImageGalleryView.h
//  GouDa
//
//  Created by 张威 on 15/9/26.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppWebImageViewDelegate.h"

@interface ZWImageGalleryView : UIView

//@property (nonatomic, copy) NSArray<AppWebImageViewDelegate> *imagesArray;
@property (nonatomic, copy) NSArray *imagesArray;

@property (nonatomic, strong) UIColor *pageControlPageIndicatorTintColor;
@property (nonatomic, strong) UIColor *pageControlCurrentPageIndicatorTintColor;

@end