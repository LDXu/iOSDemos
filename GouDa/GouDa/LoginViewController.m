//
//  LoginViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/12.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "LoginViewController.h"
#import "Register1ViewController.h"
#import "MainNavigationController.h"
#import "AppHTTPSessionManager+User.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *inputBgView;

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetPasswordButton;
@property (nonatomic, strong) UIButton *registerButton;

@end

@implementation LoginViewController

- (void)initViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.inputBgView                 = [[UIView alloc] init];
//    self.inputBgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.inputBgView];
    
    self.avatarImageView                 = [[UIImageView alloc] init];
    self.avatarImageView.backgroundColor = [UIColor redColor];
    [self.inputBgView addSubview:self.avatarImageView];
    

    self.userNameTextField = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.borderStyle  = UITextBorderStyleNone;
        textField.delegate     = self;
        textField.placeholder  = @"手机号码";
        textField.font         = [UIFont systemFontOfSize:16.f];
        textField.textColor    = [UIColor appFontBlackColor];
        textField.keyboardType = UIKeyboardTypePhonePad;
        textField;
    });
    [self.inputBgView addSubview:self.userNameTextField];
    
    UIView *userNameTextFieldBottomLine = [[UIView alloc] init];
    userNameTextFieldBottomLine.backgroundColor = [UIColor appSeparatorGrayColor2];
    [self.inputBgView addSubview:userNameTextFieldBottomLine];

    self.passwordTextField = ({
        UITextField *textField    = [[UITextField alloc] init];
        textField.borderStyle     = UITextBorderStyleNone;
        textField.delegate        = self;
        textField.placeholder     = @"密码";
        textField.font            = [UIFont systemFontOfSize:16.f];
        textField.textColor       = [UIColor appFontBlackColor];
        textField.keyboardType    = UIKeyboardTypeDefault;
        textField.secureTextEntry = YES;
        textField;
    });
    [self.inputBgView addSubview:self.passwordTextField];
    
    UIView *passwordTextFieldBottomLine = [[UIView alloc] init];
    passwordTextFieldBottomLine.backgroundColor = [UIColor appSeparatorGrayColor2];
    [self.inputBgView addSubview:passwordTextFieldBottomLine];
    
    self.loginButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor appFontBrownColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18.f];
        button.backgroundColor = [UIColor appLightYellowColor];
        [button addTarget:self
                   action:@selector(loginButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.inputBgView addSubview:self.loginButton];
    
    self.forgetPasswordButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor appFontBrownColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [button addTarget:self
                   action:@selector(forgetPasswordButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    self.forgetPasswordButton.alpha = 0.f;
    [self.inputBgView addSubview:self.forgetPasswordButton];
    
    self.registerButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"注册狗搭账号" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor appFontBrownColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [button addTarget:self
                   action:@selector(registerButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    self.registerButton.alpha = 1.f;
    [self.inputBgView addSubview:self.registerButton];

    
    UIEdgeInsets viewEdgeInsets = UIEdgeInsetsMake(statusBarHeight + navigationBarHeight, 20, 100, 20);
    
    [self.inputBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).insets(viewEdgeInsets);
        make.right.equalTo(self.view).insets(viewEdgeInsets);
        make.top.equalTo(self.view).insets(viewEdgeInsets);
    }];

#define kAvatarDiameter     90.f
#define kAvatarMarginTop    20.f
#define kAvatarMarginBottom 50.f    //kAvatarMarginTop
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.inputBgView);
        make.top.equalTo(self.inputBgView).offset(kAvatarMarginTop);
        make.width.equalTo(@kAvatarDiameter);
        make.height.equalTo(@kAvatarDiameter);
    }];
    self.avatarImageView.layer.cornerRadius = kAvatarDiameter / 2;

#define kTextFieldHeight    30.f
#define kButtonHeight       40.f
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(kAvatarMarginBottom);
        make.height.equalTo(@kTextFieldHeight);
    }];
    
    [userNameTextFieldBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.userNameTextField.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.userNameTextField.mas_bottom).offset(10);
        make.height.equalTo(@kTextFieldHeight);
    }];
    
    [passwordTextFieldBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.passwordTextField.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.inputBgView.mas_centerX);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@kButtonHeight);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputBgView);
        make.right.equalTo(self.inputBgView);
        make.top.equalTo(self.forgetPasswordButton.mas_bottom).offset(10);
        make.height.equalTo(@kButtonHeight);
    }];
    self.loginButton.layer.cornerRadius = appCommonCornerRadius;
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.inputBgView);
        make.width.equalTo(@140);
        make.height.equalTo(@kButtonHeight);
        make.top.equalTo(self.loginButton.mas_bottom).offset(10);
        make.bottom.equalTo(self.inputBgView.mas_bottom).offset(-20);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    self.title = @"登录";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

// 点击self.view其余部分隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)keyBoardWillShow:(NSNotification *)notification {
    
    NSDictionary *keyboardInfo = [notification userInfo];
    
    CGFloat keyboardAnimationDuration = [keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGFloat ty = 0 - kAvatarMarginTop - kAvatarDiameter - navigationBarHeight - statusBarHeight - 5;
    
    [UIView animateWithDuration:keyboardAnimationDuration
                     animations:^{
                         self.forgetPasswordButton.alpha = 1.f;
                         self.registerButton.alpha       = 0.f;
                         self.inputBgView.transform      = CGAffineTransformMakeTranslation(0, ty);
                     }];
}

- (void)keyBoardWillHide:(NSNotification *)notification {
    CGFloat keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
        self.forgetPasswordButton.alpha = 0.f;
        self.registerButton.alpha       = 1.f;
        self.inputBgView.transform      = CGAffineTransformIdentity;
    }];
}

#pragma mark - acitons

- (void)loginButtonClicked:(id)sender {
//    DLog(@"登录");
    AppHTTPSessionManager *httpSessionManager = [AppHTTPSessionManager sharedHTTPManager];

    WeakSelf(weakSelf);
    [httpSessionManager loginWithPhone:@"011"
                              password:@"123456"
                               success:^(NSDictionary *resultDic) {
                                   DLog(@"登录成功");
                                   // get userID
                                   MainNavigationController *mainNavigationController =
                                   (MainNavigationController *)weakSelf.navigationController;
                                   // update userID
                                   // [mainNavigationController updateUserID:userID];
                                   [mainNavigationController updateUserInfoWithDict:resultDic];
                                   // jump to tab bar controller
                                   [mainNavigationController showTabBarController];
                               }
                               failure:^(NSError *error) {
                                   [SVProgressHUD showInfoWithStatus:error.localizedDescription];
                               }];
}

- (void)forgetPasswordButtonClicked:(id)sender {
    DLog(@"忘记密码");
}

- (void)registerButtonClicked:(id)sender {
//    DLog(@"注册");
    Register1ViewController *VC = [[Register1ViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
