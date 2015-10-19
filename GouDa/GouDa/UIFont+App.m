//
//  UIFont+App.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "UIFont+App.h"

@implementation UIFont (App)

+ (UIFont *)appViewControllerTitleFont {
    return [UIFont systemFontOfSize:16.f];
}

+ (UIFont *)appBarButtonItemTitleFont {
    return [UIFont systemFontOfSize:14.f];
}

+ (UIFont *)appDataPickerTitleFont {
    return [UIFont systemFontOfSize:18.f];
}

@end
