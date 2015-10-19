//
//  GDStatusContentView.m
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/21.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "GDStatusContentView.h"

@interface GDStatusContentView ()

@property (nonatomic, strong) UIView *topPaddingView;
@property (nonatomic, strong) UIView *bottomPaddingView;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation GDStatusContentView {
    UILabel *_innerLabel;
}

#define kTextFont       [UIFont systemFontOfSize:14.f]
#define kTextColor      [UIColor appFontBlackColor]

// top, left, bottom, right
static UIEdgeInsets edgeInsets = {4, 0, 4, 0};

- (void)commonInit {

    _didSetupConstraints = NO;
    
    _topPaddingView = ({
        UIView *view = [[UIView alloc] init];
        view;
    });
    [self addSubview:_topPaddingView];
    
    _innerLabel = ({
        UILabel *label                  = [[UILabel alloc] init];
        label.adjustsFontSizeToFitWidth = NO;
        label.font                      = kTextFont;
        label.textColor                 = kTextColor;
        label.numberOfLines             = 0;
        label;
    });
    [self addSubview:_innerLabel];
    
    _bottomPaddingView = ({
        UIView *view = [[UIView alloc] init];
        view;
    });
    [self addSubview:_bottomPaddingView];
    
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
    [_innerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(edgeInsets);
    }];
}

- (void)updateConstraints {
    if (!_didSetupConstraints) {
        
        [self setupConstraints];
        _didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)setPreferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth {
    _preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    _innerLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
}
/*
- (CGSize)intrinsicContentSize {
    CGSize size = [_innerLabel sizeThatFits:CGSizeMake(self.maxWidth, CGFLOAT_MAX)];
    size.height += (edgeInsets.top + edgeInsets.bottom);
//    DLog(@"size = %@", NSStringFromCGSize(size));
    DLog(@"fuck2");
    return size;
}
 */

#pragma mark - setters

- (void)setText:(NSString *)text {
    /*
    if ([_text isEqualToString:text]) {
        return;
    }
     */
    _text            = [text copy];
    _innerLabel.text = _text;
    [self setNeedsLayout];
}

#pragma mark - Others

- (void)prepareForReuse {
    self.text = nil;
}

@end
