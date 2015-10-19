//
//  ZhiTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/21.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ZhiTableViewController.h"
#import "ZWSegmentedControl.h"
#import "UIView+App.h"
#import "HotProblemsTableViewCell.h"
#import "ZWImageGalleryView.h"
#import "ZWWebImageView.h"

@interface ZhiTableViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ZWSegmentedControl *segmentedControl;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) UIScrollView *pageScrollView;

@property (nonatomic, copy) NSArray *tableViewsArray;

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) ZWImageGalleryView *imageGlaleryView;

@end

#define kImageGlaleryViewWidth  mainScreenWidth
#define kImageGlaleryViewHeight (mainScreenWidth / 2)


@implementation ZhiTableViewController

- (void)loadView {
    self.view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
}

- (void)initViews {
    
    // configure navigation bar
    self.navigationItem.leftBarButtonItem =
    [UIView barButtonItemWithTitle:@"弹窗"
                            target:self
                            action:@selector(leftBarButtonItemClicked:)];

    self.segmentedControl =
    [UIView segmentedControlWithItems:@[@"热门", @"发现"]
                               target:self
                               action:@selector(segmentedControlClicked:)];
    self.segmentedControl.frame = CGRectMake(0, 0, kNavigationSegmentControlWidthWithTwoItems, kNavigationSegmentControlHeight);
    
    self.navigationItem.titleView = self.segmentedControl;

    // configure search bar
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.placeholder = @"输入关键字搜索问题";
    self.searchController.searchBar.frame = CGRectMake(0, 0, mainScreenWidth, navigationBarHeight);
    self.searchController.searchBar.barTintColor = [UIColor appViewControllerGrayBackgroundColor];
    // 盖住searchBar底部的线条
    self.searchController.searchBar.layer.borderWidth = 1.f;
    self.searchController.searchBar.layer.borderColor = [[UIColor appViewControllerGrayBackgroundColor] CGColor];
    [self.view addSubview:self.searchController.searchBar];
    
    // configure page scroll view
    self.pageScrollView = ({
        UIScrollView *scrollView =
        [[UIScrollView alloc] initWithFrame:CGRectMake(0, navigationBarHeight,
                                                      mainScreenWidth,
                                                      mainScreenHeight-navigationBarHeight*2
                                                       - statusBarHeight)];
        scrollView.backgroundColor                = [UIColor appViewControllerGrayBackgroundColor];
        scrollView.contentSize                    = CGSizeMake(mainScreenWidth * 2, scrollView.frame.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator   = NO;
        scrollView.scrollEnabled                  = false;// 不允许滑动
        scrollView.pagingEnabled                  = YES;
        scrollView.bounces                        = NO;
        scrollView.delegate                       = self;
        scrollView;
    });
    [self.view addSubview:self.pageScrollView];
    
    // configure two tableviews
    self.leftTableView = ({
        UITableView *tableView
        = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.pageScrollView.bounds.size.width,
                                                        self.pageScrollView.frame.size.height)];
        tableView.backgroundColor = [UIColor appViewControllerGrayBackgroundColor];
        tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        tableView.delegate        = self;
        tableView.dataSource      = self;
        tableView.tableFooterView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, tabBarHeight)];
            view;
        });
        tableView;
    });
    
    self.imageGlaleryView =
    [[ZWImageGalleryView alloc] initWithFrame:CGRectMake(0, 0, kImageGlaleryViewWidth, kImageGlaleryViewHeight)];
    self.leftTableView.tableHeaderView = self.imageGlaleryView;
    
    self.rightTableView = ({
        UITableView *tableView
        = [[UITableView alloc] initWithFrame:CGRectMake(self.pageScrollView.bounds.size.width, 0,
                                                        self.pageScrollView.bounds.size.width,
                                                        self.pageScrollView.frame.size.height)];
        tableView.backgroundColor = [UIColor appViewControllerGrayBackgroundColor];
        tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        tableView.delegate        = self;
        tableView.dataSource      = self;
        tableView.tableFooterView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, tabBarHeight)];
            view;
        });
        tableView;
    });
    
    [self.pageScrollView addSubview:self.leftTableView];
    [self.pageScrollView addSubview:self.rightTableView];
}

static NSString * const myCellIdentifier = @"MyCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    [self.leftTableView registerClass:[HotProblemsTableViewCell class]
               forCellReuseIdentifier:myCellIdentifier];
    [self.rightTableView registerClass:[HotProblemsTableViewCell class]
                forCellReuseIdentifier:myCellIdentifier];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    
    ZWWebImageView *webImageView1 =
    [[ZWWebImageView alloc] initWithFrame:CGRectMake(0, 0, kImageGlaleryViewWidth, kImageGlaleryViewHeight)];
    ZWWebImageView *webImageView2 =
    [[ZWWebImageView alloc] initWithFrame:CGRectMake(0, 0, kImageGlaleryViewWidth, kImageGlaleryViewHeight)];
    ZWWebImageView *webImageView3 =
    [[ZWWebImageView alloc] initWithFrame:CGRectMake(0, 0, kImageGlaleryViewWidth, kImageGlaleryViewHeight)];

    webImageView1.backgroundColor = [UIColor redColor];
    webImageView2.backgroundColor = [UIColor greenColor];
    webImageView3.backgroundColor = [UIColor blueColor];
    self.imageGlaleryView.imagesArray = @[webImageView1, webImageView2, webImageView3];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotProblemsTableViewCell *cell =
    (HotProblemsTableViewCell *) [tableView dequeueReusableCellWithIdentifier:myCellIdentifier
                                                                 forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return 100;
    } else if (tableView == self.rightTableView) {
        return 150.f;
    }
    return [HotProblemsTableViewCell height];
}

#pragma mark - UITableViewDelegate

#pragma mark - target-action


- (void)leftBarButtonItemClicked:(id)sender {
    DLog(@"leftBarButtonItemClicked");
//    [SVProgressHUD showSuccessWithStatus:@"主人您成功关注了对方"];
    [SVProgressHUD showInfoWithStatus:@"主人您成功关注了对方主人您成功关注了对方主人您成功关注了对方"];
}

/*
- (void)rightBarButtonItemClicked:(id)sender {
    DLog(@"rightBarButtonItemClicked");
}
 */

- (void)segmentedControlClicked:(ZWSegmentedControl *)sender {
    
    CGRect rect = self.pageScrollView.bounds;
    rect.origin.x = rect.size.width * sender.selectedSegmentIndex;
    [self.pageScrollView setContentOffset:CGPointMake(rect.origin.x, rect.origin.y) animated:YES];
}

@end
