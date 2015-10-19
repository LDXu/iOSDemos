//
//  FilterTableviewController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "FilterTableviewController.h"
#import "ZWTableViewCell.h"
#import "CheckedButton.h"

@implementation FilterTableviewController

static NSString * const myCellIdentifier = @"MyCellIdentifier";

- (void)initViews {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    [self.tableView registerClass:[ZWTableViewCell class] forCellReuseIdentifier:myCellIdentifier];
    
    self.title = @"筛选";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    cell.hideBottomLine   = false;
    cell.bottomLineColor  = [UIColor appSeparatorGrayColor2];
    cell.bottomLineHeight = 1.f;
    cell.backgroundColor  = [UIColor whiteColor];
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    cell.titleColor       = [UIColor appFontBlackColor];
    cell.titleFont        = [UIFont systemFontOfSize:14.0];
    cell.cellPadding      = appCommonTableViewCellLeftPadding;
    
    switch (indexPath.row) {
        case 0:
            cell.title = @"筛选开关";
            cell.detailView = ({
                UISwitch *sw = [[UISwitch alloc] init];
                sw.on = false;
                sw;
            });
            break;
        case 1:
            cell.title = @"主人性别";
            cell.detailView = ({
                UIView *bgView =
                [[UIView alloc] initWithFrame:CGRectMake(0, 0, 170, 40)];
                
                // 男
                CheckedButton *manButton = [[CheckedButton alloc] initWithFrame:CGRectMake(0, 5, 50, 30)];
                manButton.title          = @"男";
                [self initCheckedButton:manButton];
                // 女
                CheckedButton *womanButton = [[CheckedButton alloc] initWithFrame:CGRectMake(60, 5, 50, 30)];
                womanButton.title          = @"女";
                [self initCheckedButton:womanButton];
                // 不限
                CheckedButton *otherButton = [[CheckedButton alloc] initWithFrame:CGRectMake(120, 5, 50, 30)];
                otherButton.title          = @"不限";
                [self initCheckedButton:otherButton];
                
                manButton.checked = false;
                womanButton.checked = false;
                otherButton.checked = false;
                
                manButton.stateChangedHandler = ^(CheckedButton * checkedButton) {
                    if (checkedButton.checked) {
                        womanButton.checked = false;
                        otherButton.checked = false;
                        DLog(@"选中：男");
                    } else {
                        DLog(@"取消：男");
                    }
                };
                womanButton.stateChangedHandler = ^(CheckedButton * checkedButton) {
                    if (checkedButton.checked) {
                        manButton.checked = false;
                        otherButton.checked = false;
                        DLog(@"选中：女");
                    } else {
                        DLog(@"取消：女");
                    }
                };
                otherButton.stateChangedHandler = ^(CheckedButton * checkedButton) {
                    if (checkedButton.checked) {
                        manButton.checked = false;
                        womanButton.checked = false;
                        DLog(@"选中：不限");
                    } else {
                        DLog(@"取消：不限");
                    }
                };
                
                [bgView addSubview:manButton];
                [bgView addSubview:womanButton];
                [bgView addSubview:otherButton];
                bgView;
            });
            break;
        case 2:
            cell.title = @"主人年龄";
            cell.detailView = ({
                UISwitch *sw = [[UISwitch alloc] init];
                sw.on = true;
                sw;
            });
            break;
        case 3:
            cell.title = @"狗性别";
            cell.detailView = ({
                UIView *bgView =
                [[UIView alloc] initWithFrame:CGRectMake(0, 0, 170, 40)];
                
                // 公
                CheckedButton *manButton = [[CheckedButton alloc] initWithFrame:CGRectMake(0, 5, 50, 30)];
                manButton.title          = @"公";
                [self initCheckedButton:manButton];
                // 母
                CheckedButton *womanButton = [[CheckedButton alloc] initWithFrame:CGRectMake(60, 5, 50, 30)];
                womanButton.title          = @"母";
                [self initCheckedButton:womanButton];
                // 不限
                CheckedButton *otherButton = [[CheckedButton alloc] initWithFrame:CGRectMake(120, 5, 50, 30)];
                otherButton.title          = @"不限";
                [self initCheckedButton:otherButton];
                
                manButton.checked = false;
                womanButton.checked = false;
                otherButton.checked = false;
                
                manButton.stateChangedHandler = ^(CheckedButton * checkedButton) {
                    if (checkedButton.checked) {
                        womanButton.checked = false;
                        otherButton.checked = false;
                        DLog(@"选中：公");
                    } else {
                        DLog(@"取消：公");
                    }
                };
                womanButton.stateChangedHandler = ^(CheckedButton * checkedButton) {
                    if (checkedButton.checked) {
                        manButton.checked = false;
                        otherButton.checked = false;
                        DLog(@"选中：母");
                    } else {
                        DLog(@"取消：母");
                    }
                };
                otherButton.stateChangedHandler = ^(CheckedButton * checkedButton) {
                    if (checkedButton.checked) {
                        manButton.checked = false;
                        womanButton.checked = false;
                        DLog(@"选中：不限");
                    } else {
                        DLog(@"取消：不限");
                    }
                };
                
                [bgView addSubview:manButton];
                [bgView addSubview:womanButton];
                [bgView addSubview:otherButton];
                bgView;
            });
            break;
        case 4:
            cell.title = @"地理位置";
            cell.detailView = ({
                UISwitch *sw = [[UISwitch alloc] init];
                sw.on = true;
                sw;
            });
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)initCheckedButton:(CheckedButton *)checkedButton {
    checkedButton.borderWidth     = 1.5f;
    checkedButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    // title color
    [checkedButton setTitleColor:[UIColor appBrownColor]
                 forCheckedState:CheckedButtonStateChecked];
    [checkedButton setTitleColor:[UIColor appBrownColor]
                 forCheckedState:CheckedButtonStateUnchecked];
    
    // border
    [checkedButton setBorderColor:[UIColor appLightGrayColor]
                  forCheckedState:CheckedButtonStateUnchecked];
    [checkedButton setBorderColor:[UIColor appLightYellowColor]
                  forCheckedState:CheckedButtonStateChecked];
    
    // background color
    [checkedButton setBackgroundColor:[UIColor clearColor]
                      forCheckedState:CheckedButtonStateUnchecked];
    [checkedButton setBackgroundColor:[UIColor appLightYellowColor]
                      forCheckedState:CheckedButtonStateChecked];
}

@end
