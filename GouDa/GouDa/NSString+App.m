//
//  NSString+App.m
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "NSString+App.h"

@implementation NSString (App)

// 判断string是否能转换为整形
+ (BOOL)isPureInt:(NSString *)string {
    if (![string isKindOfClass:[NSString class]]) {
        return false;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 *  字符串 -> 数组
 *
 *  @param sourceString    原字符串
 *  @param seperatorString 分割字符串
 *
 *  @return 数组
 */
+ (NSArray<NSString *> *)splitStringToArray:(NSString *)sourceString
                              withSeperator:(NSString *)seperatorString {
    
    if (![sourceString isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSString *temp = [sourceString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [temp componentsSeparatedByString:seperatorString];
}

@end
