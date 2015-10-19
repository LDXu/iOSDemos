//
//  GDStatusBottomView.m
//  GouDa
//
//  Created by 张威 on 15/10/16.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "GDStatusBottomView.h"

@interface GDStatusBottomView ()

// 发布时间
@property (nonatomic, strong) UILabel *timeInfoLabel;

// 点赞
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likiesLabel;

// 评论
@property (nonatomic, strong) UIButton *replyButton;
@property (nonatomic, strong) UILabel *repliesLabel;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end


@implementation GDStatusBottomView

static CGFloat likesLabelWidth;
static CGFloat repliesLabelWidth;

#define kLabelFont          [UIFont boldSystemFontOfSize:12.f]
#define kLabelTextColor     [UIColor appFontMiddleGrayColor]

+ (void)initialize {
    UILabel *prototypeLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.text          = @"99+";
        label.font          = kLabelFont;
        label.textColor     = kLabelTextColor;
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    CGSize size       = [prototypeLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    likesLabelWidth   = size.width;
    repliesLabelWidth = size.width;
}

- (void)commonInit {
    
    _didSetupConstraints = NO;
    
    _timeInfo     = nil;
    _likes        = 0;
    _replies      = 0;
    _likeSelected = NO;
    
    _timeInfoLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.font          = kLabelFont;
        label.textColor     = kLabelTextColor;
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [self addSubview:_timeInfoLabel];
    
    _likeButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"ic_offlike.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"ic_like.png"] forState:UIControlStateSelected];
        button.selected = NO;
        [button addTarget:self
                   action:@selector(likeButtonDidClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:_likeButton];
    
    _likiesLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.font          = kLabelFont;
        label.textColor     = kLabelTextColor;
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [self addSubview:_likiesLabel];
    
    _replyButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"ic_comment.png"] forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(replyButtonDidClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:_replyButton];
    
    _repliesLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.font          = kLabelFont;
        label.textColor     = kLabelTextColor;
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    [self addSubview:_repliesLabel];
    
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
    UIEdgeInsets superViewEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    // set constraints
    [_timeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).insets(superViewEdgeInsets);
        make.bottom.equalTo(superView).insets(superViewEdgeInsets);
        make.left.equalTo(superView).insets(superViewEdgeInsets);
        make.width.equalTo(@160);
    }];
    
#define kSpacingBetweenButtonAndLabel   (0.f)
    //#define kButtonWidth    (24.f)
    //#define kButtonHeight   (24.f)
    [_repliesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView).insets(superViewEdgeInsets);
        make.centerY.equalTo(_timeInfoLabel.mas_centerY);
        make.width.equalTo([NSNumber numberWithFloat:repliesLabelWidth]);
    }];
    
    [_replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_repliesLabel.mas_left).offset(-kSpacingBetweenButtonAndLabel);
        make.centerY.equalTo(_repliesLabel.mas_centerY);
        //make.width.equalTo(@kButtonWidth);
        //make.height.equalTo(@kButtonHeight);
        make.height.equalTo(superView.mas_height);
        make.width.equalTo(superView.mas_height);
    }];
    
    [_likiesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_replyButton.mas_left);
        make.centerY.equalTo(_timeInfoLabel.mas_centerY);
        make.width.equalTo([NSNumber numberWithFloat:repliesLabelWidth]);
    }];
    
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_likiesLabel.mas_left).offset(-kSpacingBetweenButtonAndLabel);
        make.centerY.equalTo(_likiesLabel.mas_centerY);
        //make.width.equalTo(@kButtonWidth);
        //make.height.equalTo(@kButtonHeight);
        make.height.equalTo(superView.mas_height);
        make.width.equalTo(superView.mas_height);
    }];
}

- (void)updateConstraints {
    
    if (!_didSetupConstraints) {
        
        [self setupConstraints];
        
        _didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - setters and getters

- (void)setLikeSelected:(BOOL)likeSelected {
    /*
    if (_likeSelected == likeSelected) {
        return;
    }
     */
    _likeSelected = likeSelected;
    self.likeButton.selected = _likeSelected;
}

- (void)setTimeInfo:(NSString *)timeInfo {
    /*
    if ([_timeInfo isEqualToString:timeInfo]) {
        return;
    }
     */
    _timeInfo = [timeInfo copy];
    self.timeInfoLabel.text = _timeInfo;
}

- (void)setLikes:(NSUInteger)likes {
    /*
    if (_likes == likes) {
        return;
    }
     */
    _likes = likes;
    if (_likes > 999) {
        self.likiesLabel.text = @"999+";
    } else {
        self.likiesLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_likes];
    }
}

- (void)setReplies:(NSUInteger)replies {
    /*
    if (_replies == replies) {
        return;
    }
     */
    _replies = replies;
    if (_replies > 999) {
        self.repliesLabel.text = @"999+";
    } else {
        self.repliesLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_replies];
    }
}

#pragma mark - actions

- (void)likeButtonDidClicked:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    // change selected state
    sender.selected = !sender.selected;
    // update self.likeSelected
    self.likeSelected  = sender.selected;
    if ([self.delegate respondsToSelector:@selector(likeButtonDidSelected:)]) {
        [self.delegate likeButtonDidSelected:self];
    }
}

- (void)replyButtonDidClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(replyButtonDidClicked:)]) {
        [self.delegate replyButtonDidClicked:self];
    }
}

#pragma mark - Others

- (void)prepareForReuse {
    self.likeSelected = NO;
    self.timeInfo     = nil;
    _likiesLabel.text = nil;
    _repliesLabel.text = nil;
}

@end
