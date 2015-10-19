//
//  WelcomeViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/12.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MainNavigationController.h"

@interface WelcomeViewController ()

#define BEGIN_LOGIN         1
#define LOGIN_FINISHED      2
#define LOGIN_FAILED        3
#define DID_PRESENT_NEW_VC  4
@property (assign, nonatomic) int controlState;
@property (assign, nonatomic) BOOL timeIsUp;
@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation WelcomeViewController

- (void)initViews {
    UILabel *welcomeLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.text          = @"欢迎，狗搭";
        label.textAlignment = NSTextAlignmentCenter;
        label.font          = [UIFont systemFontOfSize:24.f];
        label.textColor     = [UIColor appFontGrayColor];
        label;
    });
    [self.view addSubview:welcomeLabel];
    
    [welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@300);
        make.height.equalTo(@300);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViews];
    
    // init state
    self.controlState = BEGIN_LOGIN;
    self.timeIsUp     = false;
    
    // 倒计时
    self.countDownTimer =
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(timeUpHandler)
                                   userInfo:nil
                                    repeats:YES];
    
    // 登录
    [self handleLogin];
    
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
}

// 登录
- (void)handleLogin {
    self.controlState = LOGIN_FINISHED;
}

// login succeed
- (void)loginSucceed {
    if (self.timeIsUp == true) {
        MainNavigationController *mainNavigationController = (MainNavigationController *)self.navigationController;
        [mainNavigationController showLoginViewController];
    }
}

// login failed
- (void)loginFailed {
    if (self.timeIsUp == true) {
//        [mainNavigationController showLoginVC];
    }
}


- (void)timeUpHandler {
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
    self.timeIsUp = true;
    
    if (self.controlState == LOGIN_FINISHED) {
        [self loginSucceed];
    } else if (self.controlState == LOGIN_FAILED){
        [self loginFailed];
    }
}

- (void)dealloc {
    if (self.countDownTimer) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
    }
}
@end
