//
//  ZhiPageViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ZhiPageViewController.h"
#import "ZWSegmentedControl.h"
#import "UIView+App.h"
#import "HotProblemsTableViewController.h"

@interface ZhiPageViewController ()

@property (nonatomic, strong) ZWSegmentedControl *segmentedControl;
@property (nonatomic, copy) NSArray *pagesArray;

@end

@implementation ZhiPageViewController  {
    HotProblemsTableViewController *_hotProblemsTableViewController1;
    HotProblemsTableViewController *_hotProblemsTableViewController2;
    
    NSArray *_page0ViewControllers; // 第一页
    NSArray *_page1ViewControllers; // 第二页
}

- (void)initViews {
    
    self.segmentedControl =
    [UIView segmentedControlWithItems:@[@"热门", @"更多"]
                               target:self
                               action:@selector(segmentedControlClicked:)];
    self.segmentedControl.frame = CGRectMake(0, 0, kNavigationSegmentControlHeight,
                                             kNavigationSegmentControlHeight);
    
    self.navigationItem.titleView = self.segmentedControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    _hotProblemsTableViewController1 = [[HotProblemsTableViewController alloc] init];
    _hotProblemsTableViewController1.view.backgroundColor = [UIColor redColor];
    _page0ViewControllers           = @[_hotProblemsTableViewController1];
    
    _hotProblemsTableViewController2                      = [[HotProblemsTableViewController alloc] init];
    _hotProblemsTableViewController2.view.backgroundColor = [UIColor greenColor];
    _page1ViewControllers                 = @[_hotProblemsTableViewController2];
    
    self.pagesArray = @[_page0ViewControllers, _page1ViewControllers];
    
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

#pragma mark - target-action

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
        [self setViewControllers:self.pagesArray[1]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:YES
                      completion:^(BOOL finished) {
                          //weakSelf.currentPageViewControllerIndex = 1;
                      }];
    }
}


@end
