//
//  BaseTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/19.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor              = [UIColor appViewControllerGrayBackgroundColor];
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.navigationItem.backBarButtonItem.title = @"返回";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return appCommonStatusBarStyle;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
