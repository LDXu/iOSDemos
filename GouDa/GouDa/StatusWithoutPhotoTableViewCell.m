//
//  StatusWithoutPhotoTableViewCell.m
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "StatusWithoutPhotoTableViewCell.h"
#import "GDStatusContentView.h"
#import "QuanStatusConfiguration.h"
#import "GDStatusPublisherInfoView.h"
#import "GDStatusBottomView.h"

@interface StatusWithoutPhotoTableViewCell ()
<GDStatusPublisherInfoViewDelegate, GDStatusBottomViewDelegate>

// 「状态」发布者头像
@property (nonatomic, strong) UIImageView *avatarImageView;
// 「状态」发布者信息
@property (nonatomic, strong) GDStatusPublisherInfoView *publisherInfoView;
// 「状态」内容
@property (nonatomic, strong) GDStatusContentView *statusContentView;
// 「状态」底部
@property (nonatomic, strong) GDStatusBottomView *statusBottomView;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation StatusWithoutPhotoTableViewCell

@dynamic likeSelected;

- (void)commonInit {
    
    _didSetupConstraints = NO;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _avatarImageView = ({
        UIImageView *imageView    = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor redColor];
        imageView;
    });
    [self.contentView addSubview:_avatarImageView];
    
    _publisherInfoView                     = [[GDStatusPublisherInfoView alloc] init];
//    _publisherInfoView.backgroundColor = [UIColor redColor];
    _publisherInfoView.showOperationButton = true;
    _publisherInfoView.delegate            = self;
    [self.contentView addSubview:_publisherInfoView];
    
    _statusContentView           = [[GDStatusContentView alloc] init];
//    _statusContentView.backgroundColor = [UIColor blueColor];
    _statusContentView.preferredMaxLayoutWidth  = mainScreenWidth - kQuanStatusCellEdgeInsets.left -
    kQuanStatusCellEdgeInsets.right - kAvatarDiameter - kSpacingBetweenAvatarAndContent -
    kStatusContentViewMarginRight;
    [self.contentView addSubview:_statusContentView];
    
    _statusBottomView          = [[GDStatusBottomView alloc] init];
//    _statusBottomView.backgroundColor = [UIColor yellowColor];
    _statusBottomView.delegate = self;
    [self.contentView addSubview:_statusBottomView];
    
    _bottomLine                 = [[UIView alloc] init];
    _bottomLine.backgroundColor = [UIColor appSeparatorGrayColor3];
    [self.contentView addSubview:_bottomLine];

    //[self setupConstraints];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - setters

- (void)setStatus:(Status *)status {
    _status = status;
    
    // pupulate view
    self.publisherInfoView.nick           = _status.publisherNick;
    self.publisherInfoView.distanceString = @"服务器未给";
    
    self.statusContentView.text = _status.content;
    
    self.statusBottomView.timeInfo     = _status.timeString;
    self.statusBottomView.replies      = _status.replies;
    self.statusBottomView.likes        = _status.likes;
    self.statusBottomView.likeSelected = _status.liked;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}

- (void)setupConstraints {
    
    UIView *superView = self.contentView;
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).insets(kQuanStatusCellEdgeInsets);
        make.top.equalTo(superView).insets(kQuanStatusCellEdgeInsets);
        make.width.equalTo(@kAvatarDiameter);
        make.height.equalTo(@kAvatarDiameter);
    }];
    self.avatarImageView.layer.cornerRadius = kAvatarDiameter / 2;
    
    [_publisherInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).insets(kQuanStatusCellEdgeInsets);
        make.left.equalTo(_avatarImageView.mas_right).offset(kSpacingBetweenAvatarAndContent);
        make.right.equalTo(superView).insets(kQuanStatusCellEdgeInsets);
        make.height.equalTo(@kPublisherInfoViewHeight);
    }];
    
    [_statusContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_publisherInfoView.mas_bottom);
        make.left.equalTo(_publisherInfoView.mas_left);
        make.right.equalTo(superView.mas_right).offset(0-kQuanStatusCellEdgeInsets.right-
                                                       kStatusContentViewMarginRight);
    }];
    
    [_statusBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statusContentView.mas_bottom);
        make.left.equalTo(_publisherInfoView.mas_left);
        make.right.equalTo(_publisherInfoView.mas_right);
        make.height.equalTo(@kStatusBottomViewHeight);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(_statusBottomView.mas_bottom);
        make.height.equalTo(@kStatusBottomLineHeight);
        make.bottom.equalTo(superView);
    }];
}

- (void)updateConstraints {
    if (!_didSetupConstraints) {

        [self setupConstraints];
        
        _didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - GDStatusPublisherInfoViewDelegate

- (void)moreOperationButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickedOperationButtonInCell:)]) {
        [self.delegate didClickedOperationButtonInCell:self];
    }
}

#pragma mark - GDStatusBottomViewDelegate

- (void)replyButtonDidClicked:(GDStatusBottomView *)view {
    if ([self.delegate respondsToSelector:@selector(didClickedReplyButtonInCell:)]) {
        [self.delegate didClickedReplyButtonInCell:self];
    }
}

- (void)likeButtonDidSelected:(GDStatusBottomView *)view {
    if ([self.delegate respondsToSelector:@selector(didSelectedLikeButtonInCell:)]) {
        [self.delegate didSelectedLikeButtonInCell:self];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.publisherInfoView prepareForReuse];
    [self.statusContentView prepareForReuse];
    [self.statusBottomView prepareForReuse];
}

#pragma mark - setters and getters

- (BOOL)likeSelected {
    return self.statusBottomView.likeSelected;
}

- (void)setLikeSelected:(BOOL)likeSelected {
    self.statusBottomView.likeSelected = likeSelected;
}

- (void)setHideBottomLine:(BOOL)hideBottomLine {
    _hideBottomLine = hideBottomLine;
    self.bottomLine.hidden = _hideBottomLine;
}

- (void)setHideOperationButton:(BOOL)hideOperationButton {
    _hideOperationButton = hideOperationButton;
    self.publisherInfoView.showOperationButton = !_hideOperationButton;
}

@end
