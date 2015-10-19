//
//  GDStatusPublisherInfoView.m
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "GDStatusPublisherInfoView.h"

@interface GDStatusPublisherInfoView ()

@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIButton *operationButton;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation GDStatusPublisherInfoView

- (void)commonInit {
    
    _didSetupConstraints = NO;
    _showOperationButton = YES;
    
    _nickLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.font          = [UIFont boldSystemFontOfSize:14.f];
        label.textColor     = [UIColor appFontBlackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [self addSubview:_nickLabel];
    
    _distanceLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.font          = [UIFont systemFontOfSize:12.f];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor     = [UIColor appFontMiddleGrayColor];
        label;
    });
    [self addSubview:_distanceLabel];
    
    _operationButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"quanMoreOperationdown.png"]
                forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(moreOperation:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:_operationButton];
    
//    [self setupConstraints];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setupConstraints {
    UIView *superView = self;
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.top.equalTo(superView);
        make.width.equalTo(@160);
        //            make.right.lessThanOrEqualTo(superView).offset(-30.f);
        //            make.right.equalTo(superView).offset(-30);
    }];
    
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.top.equalTo(_nickLabel.mas_bottom);
        make.bottom.equalTo(superView);
        make.right.equalTo(_nickLabel.mas_right);
        make.width.equalTo(_nickLabel.mas_width);
        make.height.equalTo(_nickLabel.mas_height);
    }];
    
    [_operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView);
        make.centerY.equalTo(superView);
        make.width.equalTo(@24);
        make.height.equalTo(@24);
    }];
}

- (void)updateConstraints {
    if (!_didSetupConstraints) {
        
        [self setupConstraints];
        
        _didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - actions

- (void)moreOperation:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(moreOperationButtonClicked:)]) {
        [self.delegate moreOperationButtonClicked:sender];
    }
}

#pragma mark - setters

- (void)setNick:(NSString *)nick {
    /*
    if (_nick == nick) {
        return;
    }
     */
    _nick           = [nick copy];
    self.nickLabel.text = _nick;
}

- (void)setDistanceString:(NSString *)distanceString {
    /*
    if (_distanceString == distanceString) {
        return;
    }
     */
    _distanceString     = [distanceString copy];
    self.distanceLabel.text = _distanceString;
}

- (void)setShowOperationButton:(BOOL)showOperationButton {
    /*
    if (_showOperationButton == showOperationButton) {
        return;
    }
     */
    _showOperationButton = showOperationButton;
    self.operationButton.hidden = !_showOperationButton;
}

#pragma mark - Others

- (void)prepareForReuse {
    self.nick = nil;
    self.distanceString = nil;
}

@end
