//
//  CheckedButton.h
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(BOOL, CheckedButtonState) {
    CheckedButtonStateUnchecked = false,
    CheckedButtonStateChecked = true,
};

@interface CheckedButton : UIButton

typedef void (^CheckedButtonStateChangedHandler)(CheckedButton *checkedButton);

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, copy) CheckedButtonStateChangedHandler stateChangedHandler;

- (void)setBackgroundColor:(UIColor *)backgroundColor forCheckedState:(CheckedButtonState)state;
- (void)setTitleColor:(UIColor *)color forCheckedState:(CheckedButtonState)state;
- (void)setBorderColor:(UIColor *)borderColor forCheckedState:(CheckedButtonState)state;
//- (void)setBorderWidth:(CGFloat)borderWidth forCheckedState:(CheckedButtonState)state;

@end
