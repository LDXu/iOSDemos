//
//  UIView+App.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "UIView+App.h"

@implementation UIView (App)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:target
                                                                     action:action];
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    // button
    UIButton *button       = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor appBrownColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont appBarButtonItemTitleFont];
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    CGSize buttonSize      = [button sizeThatFits:CGSizeMake(100, navigationBarHeight)];
    button.frame           = CGRectMake(leftBarButtonItemLeftMargin, 0, buttonSize.width, navigationBarHeight);
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}

+ (ZWSegmentedControl *)segmentedControlWithItems:(NSArray *)items target:(id)target action:(SEL)action {
    ZWSegmentedControl *segmentedControl = [[ZWSegmentedControl alloc] initWithItems:items];
    
    segmentedControl.backgroundColor = [UIColor appBrownColor];

    segmentedControl.tintColor       = [UIColor whiteColor];
    segmentedControl.cornerRadius    = appCommonCornerRadius;
    
    [segmentedControl addTarget:target
                         action:action
               forControlEvents:UIControlEventTouchUpInside];
    return segmentedControl;
}

+ (ActionSheetStringPicker *)actionSheetStringPickerWithTitle:(NSString *)title
                                                         rows:(NSArray *)strings
                                             initialSelection:(NSInteger)index
                                                    doneBlock:(ActionStringDoneBlock)doneBlock
                                                  cancelBlock:(ActionStringCancelBlock)cancelBlockOrNil
                                                        origin:(id)origin {
    ActionSheetStringPicker *actionSheetPicker =
    [[ActionSheetStringPicker alloc] initWithTitle:title
                                              rows:strings
                                  initialSelection:index
                                         doneBlock:^(ActionSheetStringPicker *picker,
                                                     NSInteger selectedIndex,
                                                     id selectedValue) {
                                             DLog(@"确定");
                                             if (doneBlock) {
                                                 doneBlock(picker, selectedIndex, selectedValue);
                                             }
                                         } cancelBlock:^(ActionSheetStringPicker *picker) {
                                             DLog(@"取消");
                                             if (cancelBlockOrNil) {
                                                 cancelBlockOrNil(picker);
                                             }
                                         } origin:origin];
    
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:nil
                                                                         action:nil];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:nil
                                                                           action:nil];
    
    NSDictionary *barButtonItemTextAttrs = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                             NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                             };
    [doneBarButtonItem setTitleTextAttributes:barButtonItemTextAttrs forState:UIControlStateNormal];
    [cancelBarButtonItem setTitleTextAttributes:barButtonItemTextAttrs forState:UIControlStateNormal];
    

    actionSheetPicker.pickerTextAttributes = @{NSForegroundColorAttributeName: [UIColor appFontGrayColor],
                                               NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                               };

    actionSheetPicker.gdToolBarColor = [UIColor appBrownColor];
    actionSheetPicker.pickerTextAttributes = @{NSForegroundColorAttributeName: [UIColor appFontGrayColor],
                                               NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                               };
    actionSheetPicker.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                              NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                              };
    [actionSheetPicker setCancelButton:cancelBarButtonItem];
    [actionSheetPicker setDoneButton:doneBarButtonItem];
    
    return actionSheetPicker;
}

+ (ActionSheetMultipleStringPicker *)actionSheetMultipleStringsPickerWithTitle:(NSString *)title
                                                                          rows:(NSArray *)strings
                                                              initialSelection:(NSArray *)indexes
                                                                     doneBlock:(ActionMultipleStringDoneBlock)doneBlock
                                                                   cancelBlock:(ActionMultipleStringCancelBlock)cancelBlockOrNil
                                                                        origin:(id)origin {
    ActionSheetMultipleStringPicker *actionSheetMultipleStringPicker =
    [[ActionSheetMultipleStringPicker alloc] initWithTitle:title
                                                      rows:strings
                                          initialSelection:indexes
                                                 doneBlock:^(ActionSheetMultipleStringPicker *picker,
                                                             NSArray *selectedIndexes,
                                                             id selectedValues) {
                                                     DLog(@"doneBlock");
                                                     if (doneBlock) {
                                                         doneBlock(picker, selectedIndexes, selectedValues);
                                                     }
                                                 }
                                               cancelBlock:^(ActionSheetMultipleStringPicker *picker) {
                                                   DLog(@"取消");
                                                   if (cancelBlockOrNil) {
                                                       cancelBlockOrNil(picker);
                                                   }
                                               }
                                                    origin:origin];
    
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:nil
                                                                         action:nil];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:nil
                                                                           action:nil];
    
    NSDictionary *barButtonItemTextAttrs = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                             NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                             };
    [doneBarButtonItem setTitleTextAttributes:barButtonItemTextAttrs forState:UIControlStateNormal];
    [cancelBarButtonItem setTitleTextAttributes:barButtonItemTextAttrs forState:UIControlStateNormal];
    
    
    actionSheetMultipleStringPicker.gdToolBarColor = [UIColor appBrownColor];
    actionSheetMultipleStringPicker.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                              NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                              };
    [actionSheetMultipleStringPicker setCancelButton:cancelBarButtonItem];
    [actionSheetMultipleStringPicker setDoneButton:doneBarButtonItem];
    
    actionSheetMultipleStringPicker.pickerTextAttributes = @{NSForegroundColorAttributeName: [UIColor appFontGrayColor],
                                                             NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                                             };
    
    return actionSheetMultipleStringPicker;
    
}

+ (ActionSheetCustomPicker *)actionSheetCustomPickerWithTitle:(NSString *)title
                                delegate:(id <ActionSheetCustomPickerDelegate>)delegate
                                  origin:(id)origin {
    ActionSheetCustomPicker *actionSheetCustomPicker =
    [[ActionSheetCustomPicker alloc] initWithTitle:@"请选择"
                                          delegate:delegate
                                  showCancelButton:YES
                                            origin:origin];
    
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:nil
                                                                         action:nil];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:nil
                                                                           action:nil];
    
    NSDictionary *barButtonItemTextAttrs = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                             NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                             };
    [doneBarButtonItem setTitleTextAttributes:barButtonItemTextAttrs forState:UIControlStateNormal];
    [cancelBarButtonItem setTitleTextAttributes:barButtonItemTextAttrs forState:UIControlStateNormal];
    
    actionSheetCustomPicker.gdToolBarColor = [UIColor appBrownColor];
    actionSheetCustomPicker.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                    NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                                    };
    [actionSheetCustomPicker setCancelButton:cancelBarButtonItem];
    [actionSheetCustomPicker setDoneButton:doneBarButtonItem];
    
    actionSheetCustomPicker.pickerTextAttributes = @{NSForegroundColorAttributeName: [UIColor appFontGrayColor],
                                                     NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                                     };
    
    return actionSheetCustomPicker;
}

+ (ActionSheetDatePicker *)ActionSheetDatePickerWithTitle:(NSString *)title
                                             selectedDate:(NSDate *)selectedDate
                                              minimumDate:(NSDate *)minimumDate
                                              maximumDate:(NSDate *)maximumDate
                                                   target:(id)target
                                                   action:(SEL)action
                                                   origin:(id)origin {
    ActionSheetDatePicker *actionDatePicker =
    [[ActionSheetDatePicker alloc] initWithTitle:title
                                  datePickerMode:UIDatePickerModeDate
                                    selectedDate:selectedDate
                                     minimumDate:minimumDate
                                     maximumDate:maximumDate
                                          target:target
                                          action:action
                                          origin:origin];
    actionDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:nil
                                                                         action:nil];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:nil
                                                                           action:nil];
    
    NSDictionary *barButtonItemTextAttrs = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                             NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                             };
    [doneBarButtonItem setTitleTextAttributes:barButtonItemTextAttrs forState:UIControlStateNormal];
    [cancelBarButtonItem setTitleTextAttributes:barButtonItemTextAttrs forState:UIControlStateNormal];
    
    actionDatePicker.gdToolBarColor = [UIColor appBrownColor];
    actionDatePicker.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                             NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                             };
    [actionDatePicker setCancelButton:cancelBarButtonItem];
    [actionDatePicker setDoneButton:doneBarButtonItem];
    
    actionDatePicker.pickerTextAttributes = @{NSForegroundColorAttributeName: [UIColor appFontGrayColor],
                                              NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                              };
    
    return actionDatePicker;
}

@end
