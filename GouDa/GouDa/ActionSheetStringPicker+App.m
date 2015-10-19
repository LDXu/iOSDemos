//
//  ActionSheetStringPicker+App.m
//  GouDa
//
//  Created by 张威 on 15/9/24.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ActionSheetStringPicker+App.h"

@implementation ActionSheetStringPicker (App)

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, floorf(mainScreenWidth / 3), 20.f)];
        label.textColor                 = [UIColor appDataPickerTitleColor];
        label.minimumScaleFactor        = 0.5;
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment             = NSTextAlignmentCenter;
        label.font                      = [UIFont appDataPickerTitleFont];
    }
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

@end
