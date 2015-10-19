//
//  ZWTableViewCell.h
//  CellsDemo
//
//  Created by 张威 on 15/7/9.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIView  *detailView;
@property (nonatomic, strong) UIImage *accessoryImage;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont  *titleFont;

@property (nonatomic, assign) CGFloat cellPadding;

// show bottom line(or 'seperator line'
@property (nonatomic, assign) BOOL hideBottomLine;
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, assign) CGFloat bottomLineHeight;

@end
