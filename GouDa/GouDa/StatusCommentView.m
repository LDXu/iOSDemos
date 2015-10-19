//
//  StatusCommentView.m
//  GouDa
//
//  Created by 张威 on 15/9/27.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "StatusCommentView.h"

@interface StatusCommentView ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UIView *topLineLabel;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end


@implementation StatusCommentView {
    UIColor * _fillColor;
}

#define kArrowHeight           (10.f)

#define kAvatarRadius          (25.f)

#define kTopLineHeight         (0.5f)

- (void)commonInit {
    
    _didSetupConstraints = NO;
    
    _fillColor = [UIColor appSeparatorGrayColor3];
    _arrowOffsetX = 100.f;
    
    if (_style == StatusCommentViewStyleFirst) {
        // {top, left, bottom, right};
        _edgeInsets          = UIEdgeInsetsMake(10+kArrowHeight, 10, 10, 10);
        self.backgroundColor = [UIColor clearColor];
        self.opaque          = false;
    } else {
        // {top, left, bottom, right};
        _edgeInsets          = UIEdgeInsetsMake(10+kTopLineHeight, 10, 10, 10);
        self.backgroundColor = _fillColor;
        self.opaque          = true;
        
        _topLineLabel                 = [[UIView alloc] init];
        _topLineLabel.backgroundColor = [UIColor appMiddleGrayColor];
        [self addSubview:_topLineLabel];
    }
    
    _avatarImageView                    = [[UIImageView alloc] init];
    _avatarImageView.backgroundColor    = [UIColor redColor];
    _avatarImageView.layer.cornerRadius = kAvatarRadius;
    [self addSubview:_avatarImageView];
    
    _nickLabel               = [[UILabel alloc] init];
    _nickLabel.textColor     = [UIColor appFontBlackColor];
    _nickLabel.font          = [UIFont systemFontOfSize:12.f];
    _nickLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_nickLabel];
//    _nickLabel.backgroundColor = [UIColor purpleColor];
    
    _timeLabel               = [[UILabel alloc] init];
    _timeLabel.textColor     = [UIColor appFontMiddleGrayColor];
    _timeLabel.font          = [UIFont systemFontOfSize:12.f];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_timeLabel];
//    _timeLabel.backgroundColor = [UIColor purpleColor];
    
    _commentLabel                           = [[UILabel alloc] init];
    _commentLabel.textColor                 = [UIColor appFontGrayColor];
    _commentLabel.adjustsFontSizeToFitWidth = NO;
    _commentLabel.textAlignment             = NSTextAlignmentLeft;
    _commentLabel.font                      = [UIFont systemFontOfSize:12.f];
    _commentLabel.numberOfLines             = 0;
    [self addSubview:_commentLabel];
//    _commentLabel.backgroundColor = [UIColor purpleColor];
}

- (instancetype)initWithStyle:(StatusCommentViewStyle)style {
    self = [super init];
    if (self) {
        _style = style;
        [self commonInit];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (_style == StatusCommentViewStyleCommon) {
        [super drawRect:rect];
        return;
    }
    // Drawing code
    //设置线条颜色
    [[UIColor clearColor] set];
    
    CGRect frame = CGRectMake(0, kArrowHeight, self.bounds.size.width, self.bounds.size.height - kArrowHeight);
    CGFloat xMin = CGRectGetMinX(frame);
    CGFloat yMin = CGRectGetMinY(frame);
    
    CGFloat xMax = CGRectGetMaxX(frame);
    CGFloat yMax = CGRectGetMaxY(frame);
    
    UIBezierPath *viewPath = [UIBezierPath bezierPath];
    [viewPath moveToPoint:CGPointMake(xMin, yMin)]; //左上角
    /********************向上的箭头**********************/
    [viewPath addLineToPoint:CGPointMake(self.arrowOffsetX - kArrowHeight, yMin)];  // 左边点
    [viewPath addLineToPoint:CGPointMake(self.arrowOffsetX, 0)];    // 上边点
    [viewPath addLineToPoint:CGPointMake(self.arrowOffsetX + kArrowHeight, yMin)];  // 右边点
    /********************向上的箭头**********************/
    [viewPath addLineToPoint:CGPointMake(xMax, yMin)];  // 右上角
    [viewPath addLineToPoint:CGPointMake(xMax, yMax)];  // 右下角
    [viewPath addLineToPoint:CGPointMake(xMin, yMax)];  // 左下角
    
    //填充颜色
    [_fillColor setFill];
    [viewPath fill];
    [viewPath closePath];
    [viewPath stroke];
}


#define kNickLabelWidth        (100.f)
#define kNickLabelHeight       (20.f)
#define kNickLabelMarginBottom (5.f)

#define kTimeLabelWidth        (120.f)
#define kTimeLabelHeight       kNickLabelHeight

#define kTopLinePaddingLeft    (5.f)
#define kTopLinePaddingRight   (5.f)

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.commentLabel.preferredMaxLayoutWidth =
    self.frame.size.width-_edgeInsets.left-kAvatarRadius*2-_edgeInsets.left-_edgeInsets.right;
    
    /*
    _topLineLabel.frame =
    CGRectMake(kTopLinePaddingLeft, 0, self.frame.size.width-kTopLinePaddingLeft-kTopLinePaddingRight, kTopLineHeight);
    
    _avatarImageView.frame =
    CGRectMake(_edgeInsets.left, _edgeInsets.top, kAvatarRadius * 2, kAvatarRadius * 2);
    
    _nickLabel.frame =
    CGRectMake(_edgeInsets.left * 2 + kAvatarRadius * 2, _edgeInsets.top, kNickLabelWidth, kNickLabelHeight);
    
    _timeLabel.frame =
    CGRectMake(self.frame.size.width - _edgeInsets.right - kTimeLabelWidth, _edgeInsets.top,
               kTimeLabelWidth, kTimeLabelHeight);
    
    CGSize commentSize =
    [_commentLabel sizeThatFits:CGSizeMake(self.frame.size.width-_edgeInsets.left-kAvatarRadius*2-_edgeInsets.left-_edgeInsets.right, CGFLOAT_MAX)];
    
    _commentLabel.frame =
    CGRectMake(_edgeInsets.left+kAvatarRadius*2+_edgeInsets.left,
               _edgeInsets.top+kNickLabelHeight+kNickLabelMarginBottom,
               self.frame.size.width-_edgeInsets.left-kAvatarRadius*2-_edgeInsets.left-_edgeInsets.right,
               commentSize.height);
     */
}

- (void)setupConstraints {
    UIView *superView = self;
    
    [_topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(superView.mas_left).offset(kTopLinePaddingLeft);
        make.right.equalTo(superView.mas_right).offset(-kTopLinePaddingLeft);
        make.height.equalTo(@kTopLineHeight);
    }];
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).insets(_edgeInsets);
        make.top.equalTo(superView).insets(_edgeInsets);
        make.width.equalTo([NSNumber numberWithFloat:kAvatarRadius*2]);
        make.height.equalTo([NSNumber numberWithFloat:kAvatarRadius*2]);
        make.bottom.lessThanOrEqualTo(superView).insets(_edgeInsets);
    }];
    
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarImageView.mas_right).offset(_edgeInsets.left);
        make.top.equalTo(_avatarImageView.mas_top);
        make.width.equalTo(@kNickLabelWidth);
        make.height.equalTo(@kNickLabelHeight);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView).insets(_edgeInsets);
        make.top.equalTo(_nickLabel.mas_top);
        make.width.equalTo(@kTimeLabelWidth);
        make.height.equalTo(@kTimeLabelHeight);
    }];

    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nickLabel.mas_left);
        make.right.equalTo(_timeLabel.mas_right);
        make.top.equalTo(_nickLabel.mas_bottom).offset(kNickLabelMarginBottom);
        make.bottom.lessThanOrEqualTo(superView).insets(_edgeInsets);
    }];
}

- (void)updateConstraints {
    if (!_didSetupConstraints) {
        
        [self setupConstraints];
        
        _didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - setters

- (void)setNickString:(NSString *)nickString {
    //    if (_nickString == nickString) {
    //        return;
    //    }
    _nickString = [nickString copy];
    self.nickLabel.text = _nickString;
}

- (void)setTimeString:(NSString *)timeString {
    //    if (_timeString == timeString) {
    //        return;
    //    }
    _timeString = [timeString copy];
    self.timeLabel.text = _timeString;
}

- (void)setCommentString:(NSString *)commentString {
    //    if (_commentString == commentString) {
    //        return;
    //    }
    _commentString = [commentString copy];
    self.commentLabel.text = _commentString;
    [self setNeedsLayout];
}

- (void)setShowTopLine:(BOOL)showTopLine {
    _showTopLine = showTopLine;
    self.topLineLabel.hidden = !_showTopLine;
}

- (void)prepareForReuse {
    self.nickString = nil;
    self.timeString = nil;
    self.commentString = nil;
    self.showTopLine = NO;
}

@end
