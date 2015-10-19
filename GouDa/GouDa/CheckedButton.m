//
//  CheckedButton.m
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "CheckedButton.h"

@interface CheckedButton ()

@end

@implementation CheckedButton {
    // background color
    UIColor *_checkedBackgroundColor;
    UIColor *_uncheckedBackgroundColor;
    
    // title color
    UIColor *_checkedTitleColor;
    UIColor *_uncheckedTitleColor;
    
    // border color
    UIColor *_checkedBorderColor;
    UIColor *_uncheckedBorderColor;
}

- (void)commonInit {
    _borderWidth          = 0.f;
    _checkedBorderColor   = [UIColor clearColor];
    _uncheckedBorderColor = [UIColor clearColor];
    _checked              = false;
    [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderWidth = self.borderWidth;
    
    [self updateAppearance];
}

#pragma mark - property setters

- (void)setBackgroundColor:(UIColor *)backgroundColor forCheckedState:(CheckedButtonState)state {
    if (state == CheckedButtonStateChecked) {
        _checkedBackgroundColor = backgroundColor;
    } else if (state == CheckedButtonStateUnchecked) {
        _uncheckedBackgroundColor = backgroundColor;
    }
}

- (void)setTitleColor:(UIColor *)color forCheckedState:(CheckedButtonState)state {
    if (state == CheckedButtonStateChecked) {
        _checkedTitleColor = color;
    } else if (state == CheckedButtonStateUnchecked) {
        _uncheckedTitleColor = color;
    }
}

- (void)setBorderColor:(UIColor *)borderColor forCheckedState:(CheckedButtonState)state {
    if (state == CheckedButtonStateChecked) {
        _checkedBorderColor = borderColor;
    } else if (state == CheckedButtonStateUnchecked) {
        _uncheckedBorderColor = borderColor;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setTitle:_title forState:UIControlStateNormal];
}

- (void)updateAppearance {
    UIColor *titleColor      = _checked ? _checkedTitleColor : _uncheckedTitleColor;
    UIColor *borderColor     = _checked ? _checkedBorderColor : _uncheckedBorderColor;
    UIColor *backgroundColor = _checked ? _checkedBackgroundColor : _uncheckedBackgroundColor;

    [self setTitleColor:titleColor forState:UIControlStateNormal];
    self.layer.borderColor = [borderColor CGColor];
    self.backgroundColor = backgroundColor;
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    _checked = checked;
    
    [self updateAppearance];
}

#pragma mark - target-action
- (void)buttonClicked:(id)sender {
    self.checked = !self.checked;
    if (self.stateChangedHandler) {
        self.stateChangedHandler(self);
    }
}

@end
