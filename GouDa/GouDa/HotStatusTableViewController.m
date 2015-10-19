//
//  HotStatusTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "HotStatusTableViewController.h"
#import "AppHTTPSessionManager+Quan.h"
#import "StatusWithoutPhotoTableViewCell.h"
#import "StatusModel.h"
#import "StatusDetailTableViewController.h"
#import "MainNavigationController.h"

@interface HotStatusTableViewController ()<StatusTableViewCellDelegate>

@property (nonatomic, strong) StatusWithoutPhotoTableViewCell *prototypeCell;
@property (nonatomic, strong) StatusModel *statusModel;

@end

@implementation HotStatusTableViewController

static NSString * const myCellIdentifier          = @"myCellIdentifier";
//static NSString * const myPrototypeCellIdentifier = @"myPrototypeCellIdentifier";

- (void)initViews {
    /*
    self.tableView.tableFooterView = ({
        UIView *view =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                 mainScreenWidth, tabBarHeight + tableFooterViewHeight)];
        view;
    });
     */
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    // configure tableView
    [self.tableView registerClass:[StatusWithoutPhotoTableViewCell class] forCellReuseIdentifier:myCellIdentifier];
//    [self.tableView registerClass:[StatusWithoutPhotoTableViewCell class] forCellReuseIdentifier:myPrototypeCellIdentifier];
    
//    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:myPrototypeCellIdentifier];
//    self.prototypeCell.tag = 10000;
    
    // Self-sizing table view cells in iOS 8 require that the rowHeight property of the table view
    // be set to the constant UITableViewAutomaticDimension
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Self-sizing table view cells in iOS 8 are enabled when the estimatedRowHeight property of the table view
    // is set to a non-zero value.
    // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath:
    // for every row in the table on first load;
    // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
    self.tableView.estimatedRowHeight = 120.f;//

    WeakSelf(weakSelf);
    AppHTTPSessionManager *httpManager = [AppHTTPSessionManager sharedHTTPManager];
    
    MainNavVC(mainNavigationController);

    [httpManager hotStatusWithUserID:mainNavigationController.userInfo.userID
                           pageIndex:0
                        countPerPage:1000
                             success:^(NSDictionary *resultDic) {
                                 StrongSelf(strongSelf);
                                 // 1. update status model
                                 strongSelf.statusModel = [[StatusModel alloc] initWithDictionary:resultDic];
                                 //Status *status = [strongSelf.statusModel statusAtIndex:0];
                                 //status.content = @"中卫喜欢色调分离就水电费流线水电费刘希茜按是否加类似的失联飞机水电费";
                                 // 2. update tableview
                                 [strongSelf.tableView reloadData];
                             }
                             failure:^(NSError *error) {
                                 [SVProgressHUD showInfoWithStatus:error.localizedDescription];
                             }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusModel.count;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.prototypeCell.status = [self.statusModel statusAtIndex:indexPath.row];
    
    [self.prototypeCell setNeedsUpdateConstraints];
    [self.prototypeCell updateConstraintsIfNeeded];
    
//    self.prototypeCell.bounds =
//    CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(self.prototypeCell.bounds));
    
    [self.prototypeCell setNeedsLayout];
    [self.prototypeCell layoutIfNeeded];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    if (size.height != 105.f) {
//    DLog(@"size.height = %f",size.height);
//    }
    return size.height+1;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusWithoutPhotoTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:myCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell ...
    cell.status   = [self.statusModel statusAtIndex:indexPath.row];
    cell.delegate = self;
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

#pragma mark - StatusTableViewCellDelegate

- (void)didClickedOperationButtonInCell:(UITableViewCell *)tableViewCell {
    DLog(@"暂无操作");
}

- (void)didClickedReplyButtonInCell:(UITableViewCell *)tableViewCell {
    DLog(@"回复");
    
    // init VC
    StatusDetailTableViewController *VC = [[StatusDetailTableViewController alloc] init];
    
    // configure VC
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tableViewCell];
    Status *status = [self.statusModel statusAtIndex:indexPath.row];
    VC.status = status;
    
    // present VC
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didSelectedLikeButtonInCell:(UITableViewCell *)tableViewCell {
    DLog(@"点赞");
}

@end
