//
//  UIView+App.h
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWSegmentedControl.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetMultipleStringPicker.h"
#import "ActionSheetCustomPicker.h"
#import "ActionSheetDatePicker.h"

@interface UIView (App)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (ZWSegmentedControl *)segmentedControlWithItems:(NSArray *)items target:(id)target action:(SEL)action;

+ (ActionSheetStringPicker *)actionSheetStringPickerWithTitle:(NSString *)title
                                                         rows:(NSArray *)strings
                                             initialSelection:(NSInteger)index
                                                    doneBlock:(ActionStringDoneBlock)doneBlock
                                                  cancelBlock:(ActionStringCancelBlock)cancelBlockOrNil
                                                       origin:(id)origin;

+ (ActionSheetMultipleStringPicker *)actionSheetMultipleStringsPickerWithTitle:(NSString *)title
                                                                          rows:(NSArray *)strings
                                                              initialSelection:(NSArray *)indexes
                                                                     doneBlock:(ActionMultipleStringDoneBlock)doneBlock
                                                                   cancelBlock:(ActionMultipleStringCancelBlock)cancelBlockOrNil
                                                                        origin:(id)origin;

+ (ActionSheetCustomPicker *)actionSheetCustomPickerWithTitle:(NSString *)title
                                                     delegate:(id <ActionSheetCustomPickerDelegate>)delegate
                                                       origin:(id)origin;

+ (ActionSheetDatePicker *)ActionSheetDatePickerWithTitle:(NSString *)title
                                             selectedDate:(NSDate *)selectedDate
                                              minimumDate:(NSDate *)minimumDate
                                              maximumDate:(NSDate *)maximumDate
                                                   target:(id)target
                                                   action:(SEL)action
                                                   origin:(id)origin;

@end
