//
//  NSString+App.h
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (App)

/**
 *  判断字符串能否转换为纯整型
 *
 *  @param string 字符串
 *
 *  @return boolean value
 */
+ (BOOL)isPureInt:(NSString *)string;

/**
 *  字符串 -> 数组
 *
 *  @param sourceString    原字符串
 *  @param seperatorString 分割字符串
 *
 *  @return 数组
 */
+ (NSArray<NSString *> *)splitStringToArray:(NSString *)sourceString
                              withSeperator:(NSString *)seperatorString;


@end
