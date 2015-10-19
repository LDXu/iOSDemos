//
//  ConfigureRemindsTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ConfigureRemindsTableViewController.h"
#import "ZWTableViewCell.h"

@implementation ConfigureRemindsTableViewController

static NSString * const myCellIdentifier = @"MyCellIdentifier";

- (void)initViews {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    [self.tableView registerClass:[ZWTableViewCell class] forCellReuseIdentifier:myCellIdentifier];
    
    self.title = @"提醒设置";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    cell.hideBottomLine   = false;
    cell.bottomLineColor  = [UIColor appSeparatorGrayColor2];
    cell.bottomLineHeight = 2.f;
    cell.backgroundColor  = [UIColor whiteColor];
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    cell.titleColor       = [UIColor appGrayColor];
    cell.titleFont        = [UIFont systemFontOfSize:14.0];
    cell.cellPadding      = appCommonTableViewCellLeftPadding;
    
    switch (indexPath.row) {
        case 0:
            cell.title = @"通知声音";
            cell.detailView = ({
                UISwitch *sw = [[UISwitch alloc] init];
                sw.on = false;
                sw;
            });
            break;
        case 1:
            cell.title = @"狗圈通知";
            cell.detailView = ({
                UISwitch *sw = [[UISwitch alloc] init];
                sw.on = true;
                sw;
            });
            break;
        case 2:
            cell.title = @"聊天提醒";
            cell.detailView = ({
                UISwitch *sw = [[UISwitch alloc] init];
                sw.on = true;
                sw;
            });
            break;
        case 3:
            cell.title = @"允许通过狗圈发起邀请";
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

@end
