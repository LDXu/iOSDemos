//
//  CommonStatusCommentTableViewCell.m
//  GouDa
//
//  Created by 张威 on 15/9/27.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "CommonStatusCommentTableViewCell.h"
#import "StatusCommentView.h"

@interface CommonStatusCommentTableViewCell ()

@property (nonatomic, strong) StatusCommentView *commentView;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation CommonStatusCommentTableViewCell

// top left bottom right
static UIEdgeInsets edgeInsets = {0, 10, 0, 10};

- (void)commonInit {
    
    _didSetupConstraints = NO;
    
    self.backgroundColor             = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _commentView = [[StatusCommentView alloc] initWithStyle:StatusCommentViewStyleCommon];
    [self.contentView addSubview:_commentView];
}

- (void)setupConstraints {
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(edgeInsets);
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}

- (void)updateConstraints {
    if (!_didSetupConstraints) {
//        DLog(@"updateConstraints");
        [self setupConstraints];
        
        _didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.commentView prepareForReuse];
}

#pragma mark - setters

- (void)setNickString:(NSString *)nickString {
//    if (_nickString == nickString) {
//        return;
//    }
    _nickString = [nickString copy];
    self.commentView.nickString = _nickString;
}

- (void)setTimeString:(NSString *)timeString {
//    if (_timeString == timeString) {
//        return;
//    }
    _timeString = [timeString copy];
    self.commentView.timeString = _timeString;
}

- (void)setCommentString:(NSString *)commentString {
//    if (_commentString == commentString) {
//        return;
//    }
    _commentString = [commentString copy];
    self.commentView.commentString = _commentString;
}

- (void)setShowTopLine:(BOOL)showTopLine {
    _showTopLine = showTopLine;
    self.commentView.showTopLine = _showTopLine;
}

@end
