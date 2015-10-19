//
//  MineTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "MineTableViewController.h"
#import "ZWTableViewCell.h"
#import "SettingsTableViewController.h"

@interface MineTableViewController ()

@end

@implementation MineTableViewController

- (void)initViews {
    
}

static NSString * const myCellIdentifier = @"myCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    [self.tableView registerClass:[ZWTableViewCell class] forCellReuseIdentifier:myCellIdentifier];
    
    self.title = @"我的";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 1;
    }
    return 0;
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
     cell.titleColor       = [UIColor appFontBlackColor];
     cell.titleFont        = [UIFont systemFontOfSize:14.0];
     cell.cellPadding      = appCommonTableViewCellLeftPadding;
     
     if (indexPath.section == 0) {
         cell.title = @"姜翔";
     } else if (indexPath.section == 1) {
         switch (indexPath.row) {
             case 0:
                 cell.iconImage = [UIImage imageNamed:@"star"];
                 cell.title = @"萌耀榜";
                 break;
             case 1:
                 cell.iconImage = [UIImage imageNamed:@"star"];
                 cell.title = @"我的邀请";
                 break;
             case 2:
                 cell.iconImage = [UIImage imageNamed:@"star"];
                 cell.title = @"收藏";
                 break;
             default:
                 break;
         }
     } else if (indexPath.section == 2) {
         cell.iconImage = [UIImage imageNamed:@"star"];
         cell.title = @"分享狗搭";
     } else if (indexPath.section == 3) {
         cell.iconImage = [UIImage imageNamed:@"star"];
         cell.title = @"设置";
     }
     
     return cell;
 }

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = false;

    if (indexPath.section == 0) {
        DLog(@"我的个人信息");
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                DLog(@"萌耀榜");
                break;
            case 1:
                DLog(@"我的邀请");
                break;
            case 2:
                DLog(@"收藏");
                break;
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        DLog(@"分享狗搭");
    } else if (indexPath.section == 3) {
        DLog(@"设置");
        SettingsTableViewController *VC = [[SettingsTableViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }

}


@end