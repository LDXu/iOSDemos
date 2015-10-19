//
//  ZWSocialView.m
//  GouDa
//
//  Created by 张威 on 15/9/25.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ZWSocialView.h"

@interface ZWSocialView ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZWSocialView

- (void)commonInit {
    _iconImageView                 = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    
    _titleLabel               = [[UILabel alloc] init];
    _titleLabel.font          = [UIFont systemFontOfSize:12.f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor     = [UIColor appGrayColor];
    [self addSubview:_titleLabel];
    
    [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)layoutSubviews {
    [super layoutSubviews];
    _iconImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    _iconImageView.layer.cornerRadius = _iconImageView.frame.size.width / 2;
    
    _titleLabel.frame = CGRectMake(0, self.frame.size.width,
                                   self.frame.size.width, self.frame.size.height - self.frame.size.width);
}

#pragma mark - setters

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    self.iconImageView.image = _icon;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}

#pragma mark - actions
- (void)clicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTappedSocialView:)]) {
        [self.delegate didTappedSocialView:self];
    }
}

@end
