//
//  ZWTableViewCell.m
//  CellsDemo
//
//  Created by 张威 on 15/7/9.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "ZWTableViewCell.h"

@implementation ZWTableViewCell {
    UILabel *_titleLabel;
    UIImageView *_iconImageView;
    UIImageView *_accessoryImageView;
    UIView *_bottomLine;
}

#define kDefaultCellPadding     16.0
#define kDefaultBottomLineColor [UIColor clearColor]

#define kSpacingBetweenIconAndTitle       10.0
#define kSpacingBetweenAccessoryAndDetail 10.0
#define kTitleLabelWidth    140.0

#define kDefaultTitleFont      [UIFont systemFontOfSize:14.0]
#define kDefaultTitleColor     [UIColor appFontBlackColor]

- (void)_commonInit_ZWTableViewCell {
    
    self.accessoryType   = UITableViewCellAccessoryNone;
    self.backgroundColor = [UIColor clearColor];

    // title label
    _titleFont = kDefaultTitleFont;
    _titleColor = kDefaultTitleColor;
    
    // bottom line
    _hideBottomLine  = false;
    _bottomLineColor = kDefaultBottomLineColor;
    _bottomLineHeight = 1.f;

    // cell padding
    _cellPadding = kDefaultCellPadding;
    
    // 配置selected background view
    self.selectedBackgroundView = ({
        UIView *view;
        view;
    });
    
    // icon image view
    _iconImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeCenter;
        imageView;
    });
    [self.contentView addSubview:_iconImageView];
    
    // title label
    _titleLabel = ({
        UILabel *label      = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font          = _titleFont;
        label.textColor     = _titleColor;
        label;
    });
    [self.contentView addSubview:_titleLabel];
    
    _accessoryImageView = ({
        UIImageView *imageView    = [[UIImageView alloc] init];
        imageView;
    });
    [self.contentView addSubview:_accessoryImageView];
    
    // bottom line
    _bottomLine = ({
        UIView *view         = [[UILabel alloc] init];
        view.hidden          = _hideBottomLine;
        view.backgroundColor = _bottomLineColor;
        view;
    });
    [self.contentView addSubview:_bottomLine];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _commonInit_ZWTableViewCell];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit_ZWTableViewCell];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _commonInit_ZWTableViewCell];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIView *superView = self.contentView;
    if (_iconImage) {
        _iconImageView.hidden = false;
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(_cellPadding);
            make.centerY.equalTo(superView.mas_centerY);
            make.width.equalTo([NSNumber numberWithFloat:_iconImage.size.width]);
            make.height.equalTo([NSNumber numberWithFloat:_iconImage.size.height]);
        }];
    } else {
        _iconImageView.hidden = true;
    }
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(_iconImage ?
                                                     _cellPadding + _iconImage.size.width +
                                                     kSpacingBetweenIconAndTitle :
                                                     _cellPadding);
        make.width.equalTo(@kTitleLabelWidth);
        make.height.equalTo(superView.mas_height);
        make.centerY.equalTo(superView.mas_centerY);
    }];
    
    if (_accessoryImage) {
        _accessoryImageView.hidden = false;
        [_accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.mas_right).offset(-_cellPadding);
            //make.width.equalTo(@kAccessorWidth);
            //make.height.equalTo(@kAccessorHeight);
            make.width.equalTo([NSNumber numberWithFloat:_accessoryImage.size.width]);
            make.height.equalTo([NSNumber numberWithFloat:_accessoryImage.size.height]);
            //make.height.equalTo(_accessoryImage.size.height);
            //make.size.equalTo(_accessoryImage.size);
            make.centerY.equalTo(superView.mas_centerY);
        }];
    } else {
        _accessoryImageView.hidden = true;
    }
    if (_detailView) {
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(superView.mas_right).offset(_accessoryImage ?
                                                           -_cellPadding - _accessoryImage.size.width -
                                                           kSpacingBetweenAccessoryAndDetail :
                                                           -_cellPadding);
            make.width.equalTo(@(_detailView.frame.size.width));
            make.height.equalTo(@(_detailView.frame.size.height));
            make.centerY.equalTo(superView.mas_centerY);
        }];
    }
    
    if (!_hideBottomLine) {
        _bottomLine.hidden = false;
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView.mas_left).offset(0);
            make.right.equalTo(superView.mas_right).offset(0);
            make.height.equalTo([NSNumber numberWithFloat:_bottomLineHeight]);
            make.bottom.equalTo(superView.mas_bottom);
        }];
    } else {
        _bottomLine.hidden = true;
    }
}

#pragma mark - setters

- (void)setDetailView:(UIView *)detailView {
    if (_detailView == detailView) {
        return;
    }
    _detailView = detailView;
    if ([detailView isKindOfClass:[UIView class]]) {
        [self.contentView addSubview:_detailView];
    }
}

- (void)setIconImage:(UIImage *)iconImage {
    if (_iconImage == iconImage) {
        return;
    }
    _iconImage           = iconImage;
    _iconImageView.image = _iconImage;
}

- (void)setTitle:(NSString *)title {
    if ([_title isEqualToString:title]) {
        return;
    }
    _title = [title copy];
    _titleLabel.text = _title;
}

- (void)setAccessoryImage:(UIImage *)accessoryImage {
    if (_accessoryImage == accessoryImage) {
        return;
    }
    _accessoryImage = accessoryImage;
    _accessoryImageView.image = _accessoryImage;
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (_titleColor == titleColor) {
        return;
    }
    _titleColor = titleColor;
    _titleLabel.textColor = _titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (_titleFont == titleFont) {
        return;
    }
    _titleFont = titleFont;
    _titleLabel.font = _titleFont;
}

- (void)setHideBottomLine:(BOOL)hideBottomLine {
    if (_hideBottomLine == hideBottomLine) {
        return;
    }
    _hideBottomLine = hideBottomLine;
    _bottomLine.hidden = _hideBottomLine;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    if (_bottomLineColor == bottomLineColor) {
        return;
    }
    _bottomLineColor = bottomLineColor;
    _bottomLine.backgroundColor = _bottomLineColor;
}

@end
