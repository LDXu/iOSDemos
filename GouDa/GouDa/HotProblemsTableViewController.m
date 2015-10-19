//
//  HotProblemsTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "HotProblemsTableViewController.h"
#import "BaseNavigationController.h"

@interface HotProblemsTableViewController ()

//@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UISearchController *searchController;

@end


@implementation HotProblemsTableViewController

- (void)loadView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = self.tableView;
}

- (void)initViews {
    //self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 44)];
    //self.searchBar.placeholder = @"输入关键字搜索问题";
    //self.tableView.tableHeaderView = self.searchBar;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.backgroundColor = [UIColor appLightGrayColor];
//    self.searchController.hidesNavigationBarDuringPresentation = false;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

@end
