//
//  FirstStatusCommentTableViewCell.m
//  GouDa
//
//  Created by 张威 on 15/9/27.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "FirstStatusCommentTableViewCell.h"
#import "StatusCommentView.h"
@interface FirstStatusCommentTableViewCell ()

@property (nonatomic, strong) StatusCommentView *commentView;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation FirstStatusCommentTableViewCell

static UIEdgeInsets edgeInsets = {0, 10, 0, 10};

- (void)commonInit {
    
    _didSetupConstraints = NO;
    
    self.backgroundColor             = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _commentView = [[StatusCommentView alloc] initWithStyle:StatusCommentViewStyleFirst];
    [self.contentView addSubview:_commentView];
    
    _commentView.arrowOffsetX = mainScreenWidth - edgeInsets.left - edgeInsets.right - 38;
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

        [self setupConstraints];
        
        _didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - setters

- (void)setNickString:(NSString *)nickString {
    if (_nickString == nickString) {
        return;
    }
    _nickString = [nickString copy];
    self.commentView.nickString = _nickString;
}

- (void)setTimeString:(NSString *)timeString {
    if (_timeString == timeString) {
        return;
    }
    _timeString = [timeString copy];
    self.commentView.timeString = _timeString;
}

- (void)setCommentString:(NSString *)commentString {
    if (_commentString == commentString) {
        return;
    }
    _commentString = [commentString copy];
    self.commentView.commentString = _commentString;
}


@end
