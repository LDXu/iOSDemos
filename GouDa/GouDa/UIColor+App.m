//
//  UIColor+App.m
//  GouDa
//
//  Created by 张威 on 15/9/18.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "UIColor+App.h"

@implementation UIColor (App)

// 浅黄色，FFF2A4
+(UIColor *)appLightYellowColor{
    return [[UIColor alloc] initWithRed:255/255.f green:242/255.f blue:164/255.f alpha:1.0];
}

// 棕色，BEA076
+ (UIColor *)appBrownColor {
    return [[UIColor alloc] initWithRed:190/255.f green:160/255.f blue:118/255.f alpha:1.0];
}

// 蓝色，00BFFF
+ (UIColor *)appBlueColor {
    return [[UIColor alloc] initWithRed:0/255.f green:191/255.f blue:255/255.f alpha:1.0];
}

// 红色，FF6666
+ (UIColor *)appRedColor {
    return [[UIColor alloc] initWithRed:255/255.f green:102/255.f blue:102/255.f alpha:1.0];
}

// 半透明棕色，BEA076，0.7
+ (UIColor *)appTransparentBrownColor {
    return [[UIColor alloc] initWithRed:190/255.f green:160/255.f blue:118/255.f alpha:0.7];
}

// D8D9D9
+ (UIColor *)appLightGrayColor {
    return [[UIColor alloc] initWithRed:216/255.f green:217/255.f blue:217/255.f alpha:1.0];
}

// C9C9CE
+ (UIColor *)appMiddleGrayColor {
    return [[UIColor alloc] initWithRed:201/255.f green:201/255.f blue:206/255.f alpha:1.0];
}

// 9B9B9B
+ (UIColor *)appGrayColor {
    return [[UIColor alloc] initWithRed:155/255.f green:155/255.f blue:155/255.f alpha:1.0];
}

// 浅紫色，CCD6AA
+ (UIColor *)appLightPurpleColor {
    return [[UIColor alloc] initWithRed:204/255.f green:214/255.f blue:170/255.f alpha:1.0];
}

// 紫色，8BACF0
+ (UIColor *)appPurpleColor {
    return [[UIColor alloc] initWithRed:139/255.f green:172/255.f blue:240/255.f alpha:1.0];
}

+ (UIColor *)appViewControllerGrayBackgroundColor {
    return [UIColor appSeparatorGrayColor2];
}

// 字体颜色
// D8D9D9
+ (UIColor *)appFontLightGrayColor {
    return [UIColor appLightGrayColor];
}

// C9C9CE
+ (UIColor *)appFontMiddleGrayColor {
    return [UIColor appMiddleGrayColor];
}

// 9B9B9B
+ (UIColor *)appFontGrayColor {
    return [UIColor appGrayColor];
}

// FFFFFF
+ (UIColor *)appFontBlackColor {
    return [UIColor blackColor];
}

// BEA076
+ (UIColor *)appFontBrownColor {
    return [UIColor appBrownColor];
}

// C8C7CC
+ (UIColor *)appSeparatorGrayColor1 {
    return [[UIColor alloc] initWithRed:200/255.f green:199/255.f blue:204/255.f alpha:1.0];
}

// EFEFF4
+ (UIColor *)appSeparatorGrayColor2 {
    return [[UIColor alloc] initWithRed:239/255.f green:239/255.f blue:244/255.f alpha:1.0];
}

// F5F5F5
+ (UIColor *)appSeparatorGrayColor3 {
    return [[UIColor alloc] initWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
}

+ (UIColor *)appDataPickerTitleColor {
    return [UIColor appFontBlackColor];
}

// 9F9F9F
+ (UIColor *)appNavigationBarBottomColor {
    return [[UIColor alloc] initWithRed:159/255.f green:159/255.f blue:159/255.f alpha:1.0];
}
@end
