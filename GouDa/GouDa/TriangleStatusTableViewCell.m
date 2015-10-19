//
//  TriangleStatusTableViewCell.m
//  GouDa
//
//  Created by 张威 on 15/10/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "TriangleStatusTableViewCell.h"
#import "TriangleView.h"

@interface TriangleStatusTableViewCell ()

@property (nonatomic, strong) TriangleView *triangleView;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end


@implementation TriangleStatusTableViewCell

static UIEdgeInsets edgeInsets = {0, 10, 0, 10};

- (void)commonInit {
    
    _didSetupConstraints = NO;
    
    self.backgroundColor             = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _triangleView = [[TriangleView alloc] init];
    [self.contentView addSubview:_triangleView];
    
    _triangleView.arrowOffsetX = mainScreenWidth - edgeInsets.left - edgeInsets.right - 38;
}

- (void)setupConstraints {
    CGFloat fixedHeight = [TriangleView fixedHeight];
    [_triangleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(edgeInsets);
        make.height.equalTo([NSNumber numberWithFloat:fixedHeight]);
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

@end
