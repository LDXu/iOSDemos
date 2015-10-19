//
//  QuanPageViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "QuanPageViewController.h"
#import "ZWSegmentedControl.h"
#import "PublishNewStatusViewController.h"
#import "BaseNavigationController.h"
#import "UIView+App.h"
//#import "RandomStatusTableViewController.h"
#import "HotStatusTableViewController.h"
#import "CityWideTableViewController.h"
#import "FollowedStatusTableViewController.h"

@interface QuanPageViewController ()

@property (nonatomic, strong) ZWSegmentedControl *segmentedControl;
@property (nonatomic, copy) NSArray *pagesArray;

@end

@implementation QuanPageViewController  {
    //RandomStatusTableViewController *_randomStatusTableViewController;
    //UIViewController *_viewController2;
    //UIViewController *_viewController3;
    CityWideTableViewController *_viewController1;
    HotStatusTableViewController *_viewController2;
    FollowedStatusTableViewController *_viewController3;
    
    NSArray *_page1ViewControllers; // 第一页
    NSArray *_page2ViewControllers; // 第二页
    NSArray *_page3ViewControllers; // 第三页
}

- (void)initViews {
    
    self.navigationItem.leftBarButtonItem =
    [UIView barButtonItemWithImage:[UIImage imageNamed:@"quan_information.png"]
                            target:self
                            action:@selector(leftBarButtonItemClicked:)];
    
    self.navigationItem.rightBarButtonItem =
    [UIView barButtonItemWithImage:[UIImage imageNamed:@"ic_edit.png"]
                            target:self
                            action:@selector(rightBarButtonItemClicked:)];
    
    self.segmentedControl =
    [UIView segmentedControlWithItems:@[@"同城", @"热门", @"关注"]
                               target:self
                               action:@selector(segmentedControlClicked:)];
    self.segmentedControl.frame = CGRectMake(0, 0, kNavigationSegmentControlWidthWithThreeItems,
                                             kNavigationSegmentControlHeight);
    
    self.navigationItem.titleView = self.segmentedControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    _viewController2                      = [[HotStatusTableViewController alloc] init];
    _viewController2.view.backgroundColor = [UIColor whiteColor];
    _page2ViewControllers                 = @[_viewController2];
    
    _viewController1                      = [[CityWideTableViewController alloc] init];
    _viewController1.view.backgroundColor = [UIColor greenColor];
    _page1ViewControllers                 = @[_viewController1];
    
    _viewController3                      = [[FollowedStatusTableViewController alloc] init];
    _viewController3.view.backgroundColor = [UIColor redColor];
    _page3ViewControllers                 = @[_viewController3];
    
    self.pagesArray = @[_page1ViewControllers, _page2ViewControllers, _page3ViewControllers];
    
    //    WeakSelf(weakSelf);
    [self setViewControllers:self.pagesArray[0]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:^(BOOL finished) {
                      //                      weakSelf.currentPageViewControllerIndex = 0;
                  }];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    
    //    self.delegate = self;
    //    self.dataSource = self;   // 可以禁止page滑动
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - target-action

// 狗圈消息
- (void)leftBarButtonItemClicked:(id)sender {
    DLog(@"狗圈消息");
}

// 新动态
- (void)rightBarButtonItemClicked:(UIBarButtonItem *)sender {
    sender.enabled = false;
    PublishNewStatusViewController *VC = [[PublishNewStatusViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:^{
        sender.enabled = true;
    }];
}

- (void)segmentedControlClicked:(ZWSegmentedControl *)sender {
    //DLog(@"sender.selectedSegmentIndex = %ld", (long)sender.selectedSegmentIndex);
    NSInteger pageIndex = [self.pagesArray indexOfObject:self.viewControllers];
    if (sender.selectedSegmentIndex == pageIndex) {
        DLog(@"do nothing");
        return;
    }
    
    //    WeakSelf(weakSelf);
    if (sender.selectedSegmentIndex == 0) {
        [self setViewControllers:self.pagesArray[0]
                       direction:UIPageViewControllerNavigationDirectionReverse
                        animated:YES
                      completion:^(BOOL finished) {
                          //weakSelf.currentPageViewControllerIndex = 0;
                      }];
    } else if (sender.selectedSegmentIndex == 1) {
        UIPageViewControllerNavigationDirection dir = UIPageViewControllerNavigationDirectionForward;
        if (pageIndex > 1) {
            dir = UIPageViewControllerNavigationDirectionReverse;
        }
        [self setViewControllers:self.pagesArray[1]
                       direction:dir
                        animated:YES
                      completion:^(BOOL finished) {
                          //weakSelf.currentPageViewControllerIndex = 1;
                      }];
    } else if (sender.selectedSegmentIndex == 2) {
        [self setViewControllers:self.pagesArray[2]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:YES
                      completion:^(BOOL finished) {
                          //weakSelf.currentPageViewControllerIndex = 1;
                      }];
    }
}

@end