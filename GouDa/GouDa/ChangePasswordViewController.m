//
//  ChangePasswordViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ZWTextField.h"
#import "UIView+App.h"

@interface ChangePasswordViewController () <UITextFieldDelegate>

@end

@implementation ChangePasswordViewController {
    ZWTextField *_oldPasswordTextField;
    ZWTextField *_newPasswordTextField;
    ZWTextField *_confirmPasswordTextField;
}

- (void)initViews {
#define lineSpacing         (20.f)
#define leftPadding         (20.f)
#define rightPadding        (20.f)
#define textFieldHeight     (30.f)
    
    UIFont *textFieldFont             = [UIFont systemFontOfSize:12.0];
    UIColor *textFieldBackgroundColor = [UIColor whiteColor];
    UIColor *textFieldTextColor       = [UIColor appGrayColor];
    UIColor *textPlaceholderColor     = [UIColor appLightGrayColor];
    UIEdgeInsets edgeInsets           = UIEdgeInsetsMake(0, 10, 0, 10);
    
    CGFloat offsetY = lineSpacing;
    
    _oldPasswordTextField = ({
        ZWTextField *textField =
        [[ZWTextField alloc] initWithFrame:CGRectMake(leftPadding,
                                                      offsetY,
                                                      mainScreenWidth - leftPadding - rightPadding, textFieldHeight)];
        textField.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"当前密码"
                                        attributes:@{NSForegroundColorAttributeName: textPlaceholderColor,
                                                     NSFontAttributeName:textFieldFont}];
        
        textField.backgroundColor     = textFieldBackgroundColor;
        textField.layer.cornerRadius  = appCommonCornerRadius;
        textField.layer.masksToBounds = YES;
        textField.font                = textFieldFont;
        textField.textColor           = textFieldTextColor;
        textField.backgroundColor     = textFieldBackgroundColor;
        textField.edgeInsets          = edgeInsets;
        textField.delegate            = self;
        textField;
    });
    
    offsetY += (lineSpacing + textFieldHeight);
    _newPasswordTextField = ({
        ZWTextField *textField =
        [[ZWTextField alloc] initWithFrame:CGRectMake(leftPadding,
                                                      offsetY,
                                                      mainScreenWidth - leftPadding - rightPadding, textFieldHeight)];
        textField.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"修改密码"
                                        attributes:@{NSForegroundColorAttributeName: textPlaceholderColor,
                                                     NSFontAttributeName:textFieldFont}];
        
        textField.backgroundColor     = textFieldBackgroundColor;
        textField.layer.cornerRadius  = appCommonCornerRadius;
        textField.layer.masksToBounds = YES;
        textField.font                = textFieldFont;
        textField.textColor           = textFieldTextColor;
        textField.backgroundColor     = textFieldBackgroundColor;
        textField.edgeInsets          = edgeInsets;
        textField.delegate            = self;
        textField;
    });
    
    offsetY += (lineSpacing + textFieldHeight);
    _confirmPasswordTextField = ({
        ZWTextField *textField =
        [[ZWTextField alloc] initWithFrame:CGRectMake(leftPadding,
                                                      offsetY,
                                                      mainScreenWidth - leftPadding - rightPadding, textFieldHeight)];
        textField.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"确认密码"
                                        attributes:@{NSForegroundColorAttributeName: textPlaceholderColor,
                                                     NSFontAttributeName:textFieldFont}];
        
        textField.backgroundColor     = textFieldBackgroundColor;
        textField.layer.cornerRadius  = appCommonCornerRadius;
        textField.layer.masksToBounds = YES;
        textField.font                = textFieldFont;
        textField.textColor           = textFieldTextColor;
        textField.backgroundColor     = textFieldBackgroundColor;
        textField.edgeInsets          = edgeInsets;
        textField.delegate            = self;
        textField;
    });
    
    [self.view addSubview:_oldPasswordTextField];
    [self.view addSubview:_newPasswordTextField];
    [self.view addSubview:_confirmPasswordTextField];
    
    // 导航栏view
    self.navigationItem.rightBarButtonItem =
    [UIView barButtonItemWithTitle:@"完成" target:self action:@selector(rightBarButtonItemClicked:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    self.title = @"修改密码";
}

#pragma mark - target-actions
- (void)rightBarButtonItemClicked:(id)sender {
    DLog(@"完成修改密码");
}

@end
