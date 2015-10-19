//
//  HotProblemsTableViewCell.m
//  GouDa
//
//  Created by 张威 on 15/9/21.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "HotProblemsTableViewCell.h"


@interface HotProblemsTableViewCell ()

// title
@property (nonatomic, strong) UILabel *titleLabel;
// content
@property (nonatomic, strong) UILabel *contentLabel;
// author avatar
@property (nonatomic, strong) UIImageView *authorAvatarImageView;
// participate count
@property (nonatomic, strong) UILabel *participateCountLabel;

@end

@implementation HotProblemsTableViewCell

- (void)commonInit {
    self.backgroundColor             = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UIView *bgView            = [[UIView alloc] init];
    bgView.backgroundColor    = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5.f;
    [self.contentView addSubview:bgView];
    
    UIView *superview = self.contentView;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(5,5,5,5);
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).insets(paddingInsets);
    }];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

+ (CGFloat)height {
    return 100.f;
}

@end
