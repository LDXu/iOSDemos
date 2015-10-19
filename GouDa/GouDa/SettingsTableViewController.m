//
//  SettingsTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "ZWTableViewCell.h"
#import "ChangePasswordViewController.h"
#import "ConfigureRemindsTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)initViews {
    
}

static NSString * const myCellIdentifier = @"myCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    [self.tableView registerClass:[ZWTableViewCell class] forCellReuseIdentifier:myCellIdentifier];
    
    self.title = @"设置";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 4;
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
    cell.titleColor       = [UIColor appGrayColor];
    cell.titleFont        = [UIFont systemFontOfSize:14.0];
    cell.cellPadding      = appCommonTableViewCellLeftPadding;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.title = @"修改密码";
                break;
            case 1:
                cell.title = @"提醒设置";
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.title = @"清除缓存";
                break;
            case 1:
                cell.title = @"清除聊天记录";
                break;
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                cell.title = @"给我们一个五星好评";
                break;
            case 1:
                cell.title = @"我想让狗搭变得更好";
                break;
            case 2:
                cell.title = @"联系我们";
                break;
            case 3:
                cell.title = @"关于狗搭";
                break;
            default:
                break;
        }
    } else if (indexPath.section == 3) {
        cell.title = @"退出登录";
    }

    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 10.f)];
    view.backgroundColor = [UIColor appSeparatorGrayColor2];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = false;
    
    if (indexPath.section == 0) {
        UIViewController *nextVC = nil;
        switch (indexPath.row) {
            case 0:
                nextVC = [[ChangePasswordViewController alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
                break;
            case 1:
                nextVC = [[ConfigureRemindsTableViewController alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        UIAlertController *alertController;
        UIAlertAction *cancelAction;
        UIAlertAction *deleteAction;
        switch (indexPath.row) {
            case 0:
                DLog(@"清除缓存");
                
                cancelAction =
                [UIAlertAction actionWithTitle:@"取消"
                                         style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * _Nonnull action) {
                                           DLog(@"取消");
                                       }];
                deleteAction =
                [UIAlertAction actionWithTitle:@"删除"
                                         style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * _Nonnull action) {
                                           DLog(@"删除");
                                       }];
                
                alertController =
                [UIAlertController alertControllerWithTitle:nil
                                                    message:@"确认清除缓存吗？"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:cancelAction];
                [alertController addAction:deleteAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                break;
            case 1:
                DLog(@"清除聊天记录");
                
                cancelAction =
                [UIAlertAction actionWithTitle:@"取消"
                                         style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * _Nonnull action) {
                                           DLog(@"取消");
                                       }];
                deleteAction =
                [UIAlertAction actionWithTitle:@"删除"
                                         style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * _Nonnull action) {
                                           DLog(@"删除");
                                       }];
                
                alertController =
                [UIAlertController alertControllerWithTitle:nil
                                                    message:@"确认删除聊天记录吗？"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:cancelAction];
                [alertController addAction:deleteAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                break;
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                DLog(@"给我们一个五星好评");
                break;
            case 1:
                DLog(@"我想让狗搭变得更好");
                break;
            case 2:
                DLog(@"联系我们");
                break;
            case 3:
                DLog(@"关于狗搭");
                break;
            default:
                break;
        }
    } else if (indexPath.section == 3) {
        DLog(@"退出登录");
        UIAlertAction *cancelAction =
        [UIAlertAction actionWithTitle:@"取消"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   DLog(@"取消");
                               }];
        UIAlertAction *okAction =
        [UIAlertAction actionWithTitle:@"退出"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   DLog(@"退出");
                               }];
        
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:nil
                                            message:@"确认删除聊天记录吗？"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
