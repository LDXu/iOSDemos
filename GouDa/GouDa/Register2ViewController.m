//
//  Register2ViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/14.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "Register2ViewController.h"
#import "HaveADogViewController.h"

@interface Register2ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *inputBgView;

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *vertifyTextField;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UIButton *protocolButton;

@end

@implementation Register2ViewController

- (void)initViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.inputBgView = [[UIView alloc] init];
    [self.view addSubview:self.inputBgView];
    
    self.phoneTextField = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.borderStyle  = UITextBorderStyleNone;
        textField.delegate     = self;
        textField.placeholder  = @"填写昵称";
        textField.font         = [UIFont systemFontOfSize:16.f];
        textField.textColor    = [UIColor appFontBlackColor];
        textField;
    });
    [self.inputBgView addSubview:self.phoneTextField];
    
    UIView *phoneTextFieldBottomLine = [[UIView alloc] init];
    phoneTextFieldBottomLine.backgroundColor = [UIColor appSeparatorGrayColor2];
    [self.inputBgView addSubview:phoneTextFieldBottomLine];
    
    self.passwordTextField = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.borderStyle  = UITextBorderStyleNone;
        textField.delegate     = self;
        textField.placeholder  = @"设置8-18位密码";
        textField.font         = [UIFont systemFontOfSize:16.f];
        textField.textColor    = [UIColor appFontBlackColor];
        textField;
    });
    [self.inputBgView addSubview:self.passwordTextField];
    
    UIView *passwordTextFieldBottomLine = [[UIView alloc] init];
    passwordTextFieldBottomLine.backgroundColor = [UIColor appSeparatorGrayColor2];
    [self.inputBgView addSubview:passwordTextFieldBottomLine];
    
    self.vertifyTextField = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.borderStyle  = UITextBorderStyleNone;
        textField.delegate     = self;
        textField.placeholder  = @"输入验证码";
        textField.font         = [UIFont systemFontOfSize:16.f];
        textField.textColor    = [UIColor appFontBlackColor];
        textField;
    });
    [self.inputBgView addSubview:self.vertifyTextField];
    
    UIView *vertifyTextFieldBottomLine = [[UIView alloc] init];
    vertifyTextFieldBottomLine.backgroundColor = [UIColor appSeparatorGrayColor2];
    [self.inputBgView addSubview:vertifyTextFieldBottomLine];
    
    self.registerButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"注册" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor appFontBrownColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18.f];
        button.backgroundColor = [UIColor appLightYellowColor];
        [button addTarget:self
                   action:@selector(registerButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        button;

    });
    [self.inputBgView addSubview:self.registerButton];
    
    self.noticeLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.text          = @"点击「注册」按钮，代表你已阅读并同意";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor     = [UIColor appFontMiddleGrayColor];
        label.font          = [UIFont systemFontOfSize:12.f];
        label;
    });
    [self.inputBgView addSubview:self.noticeLabel];
    
    self.protocolButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"狗搭协议" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [button addTarget:self action:@selector(protocolButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.inputBgView addSubview:self.protocolButton];
    
    UIEdgeInsets viewEdgeInsets = UIEdgeInsetsMake(statusBarHeight + navigationBarHeight, 20, 100, 20);
    
    [self.inputBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).insets(viewEdgeInsets);
        make.right.equalTo(self.view).insets(viewEdgeInsets);
        make.top.equalTo(self.view).insets(viewEdgeInsets);
    }];
    
#define kTextFieldHeight    30.f
#define kButtonHeight       40.f

    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.inputBgView.mas_top).offset(30.f);
        make.height.equalTo(@kTextFieldHeight);
    }];
    
    [phoneTextFieldBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.phoneTextField.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(10);
        make.height.equalTo(@kTextFieldHeight);
    }];
    
    [passwordTextFieldBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.passwordTextField.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.vertifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(10);
        make.height.equalTo(@kTextFieldHeight);
    }];
    
    [vertifyTextFieldBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.vertifyTextField.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.vertifyTextField.mas_bottom).offset(20);
        make.height.equalTo(@kButtonHeight);
    }];
    self.registerButton.layer.cornerRadius = appCommonCornerRadius;
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.inputBgView.mas_centerX);
        make.top.equalTo(self.registerButton.mas_bottom);
        make.height.equalTo(@24);
    }];
    
    [self.protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.inputBgView.mas_centerX);
        make.top.equalTo(self.noticeLabel.mas_bottom);
        make.height.equalTo(@24);
        make.bottom.equalTo(self.inputBgView.mas_bottom).offset(-20);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"输入手机号";
    
    [self initViews];
    
    // notificate keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

// 点击self.view其余部分隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)keyBoardWillShow:(NSNotification *)notification {
    
    NSDictionary *keyboardInfo = [notification userInfo];
    
    CGFloat keyboardAnimationDuration = [keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
    CGFloat ty = 0 - statusBarHeight - navigationBarHeight;
    
    [UIView animateWithDuration:keyboardAnimationDuration
                     animations:^{
                         [self.navigationController setNavigationBarHidden:YES animated:YES];
                         self.inputBgView.transform = CGAffineTransformMakeTranslation(0, ty);
                     }];
}

- (void)keyBoardWillHide:(NSNotification *)notification {
    CGFloat keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.inputBgView.transform      = CGAffineTransformIdentity;
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - actions 

- (void)registerButtonClicked:(UIButton *)sender {
//    DLog(@"注册");
    HaveADogViewController *VC = [[HaveADogViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)protocolButtonClicked:(UIButton *)sender {
    DLog(@"阅读协议");
    [self.view endEditing:YES];
}

@end
