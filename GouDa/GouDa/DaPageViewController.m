//
//  DaPageViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/20.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "DaPageViewController.h"
#import "FilterTableviewController.h"
#import "ZWSegmentedControl.h"
#import "MapSlideMapSegmentController.h"
#import "UIView+App.h"
#import "AreaActionSheetPickerDelegate.h"
#import "ZWSocialSharedView.h"
#import "FuckViewController.h"

@interface DaPageViewController()
<UIPageViewControllerDelegate, UIPageViewControllerDataSource, ActionSheetCustomPickerDelegate>

@property (nonatomic, strong) ZWSegmentedControl *segmentedControl;
@property (nonatomic, copy) NSArray *pagesArray;

//@property (nonatomic, assign) NSInteger currentPageViewControllerIndex;

@property (nonatomic, strong) ZWSocialSharedView *socialSharedView;

@end


@implementation DaPageViewController  {
    MapSlideMapSegmentController *_mapSlideMapSegmentController;
    UIViewController *_viewController1;
    
    NSArray *_page0ViewControllers; // 第一页
    NSArray *_page1ViewControllers; // 第二页
}

- (void)initViews {
    
    self.navigationItem.leftBarButtonItem =
    [UIView barButtonItemWithTitle:@"筛选"
                            target:self
                            action:@selector(leftBarButtonItemClicked:)];
    
    self.navigationItem.rightBarButtonItem =
    [UIView barButtonItemWithImage:[UIImage imageNamed:@"ic_information"]
                            target:self
                            action:@selector(rightBarButtonItemClicked:)];

    self.segmentedControl =
    [UIView segmentedControlWithItems:@[@"场景", @"发现"]
                               target:self
                               action:@selector(segmentedControlClicked:)];
    self.segmentedControl.frame = CGRectMake(0, 0, kNavigationSegmentControlWidthWithTwoItems,
                                             kNavigationSegmentControlHeight);
    
    self.navigationItem.titleView = self.segmentedControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    _mapSlideMapSegmentController                      = [[MapSlideMapSegmentController alloc] init];
    _mapSlideMapSegmentController.view.backgroundColor = [UIColor redColor];
    _page0ViewControllers                 = @[_mapSlideMapSegmentController];
    
    _viewController1                      = [[UIViewController alloc] init];
    _viewController1.view.backgroundColor = [UIColor greenColor];
    _page1ViewControllers                 = @[_viewController1];
    
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

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController {
    //if (viewController == _viewController2) {
    //    return _viewController1;
    //}
    return nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController {
    //if (viewController == _viewController1) {
    //    return _viewController2;
    //}
    return nil;
}

- (ZWSocialSharedView *)socialSharedView {
    if (_socialSharedView == nil) {
        _socialSharedView = [[ZWSocialSharedView alloc] init];
    }
    return _socialSharedView;
}

#pragma mark - target-action

- (void)leftBarButtonItemClicked:(id)sender {
    DLog(@"筛选");
    static int i = 0;

    if (i % 4 == 0) {
        FilterTableviewController *VC = [[FilterTableviewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (i % 4 == 1) {
        FuckViewController *VC = [[FuckViewController alloc] init];
        VC.blurStyle = UIBlurEffectStyleLight;
        [self presentViewController:VC animated:YES completion:nil];
        //[[MainTabBarController sharedMainTabBarController] showMenu];
    } else if (i % 4 == 2) {
    
        [[MainTabBarController sharedMainTabBarController] showMenu];
    }
    else {
        [self.socialSharedView show];
    }
    ++i;
}

- (void)rightBarButtonItemClicked:(id)sender {
    DLog(@"消息");
    [[MainTabBarController sharedMainTabBarController] showMenu];
    return;
/*
    static int i = 0;
    if (i % 3 == 0) {
        ActionSheetStringPicker *dataPicker =
        [UIView actionSheetStringPickerWithTitle:@"请选择"
                                            rows:@[@"1天", @"2天", @"3天", @"4天"]
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           DLog(@"选择");
                                       } cancelBlock:^(ActionSheetStringPicker *picker) {
                                           DLog(@"取消");
                                       } origin:self.view];
        [dataPicker showActionSheetPicker];
    } else if (i % 3 == 1) {
        ActionSheetDatePicker *dataPicker =
        [UIView ActionSheetDatePickerWithTitle:@"请选择"
                                  selectedDate:[NSDate date]
                                   minimumDate:[NSDate date]
                                   maximumDate:[NSDate date]
                                        target:self
                                        action:@selector(dateWasSelected:element:)
                                        origin:self.view];
        [dataPicker showActionSheetPicker];
    } else if (i % 3 == 2) {
        AreaActionSheetPickerDelegate *delegate = [[AreaActionSheetPickerDelegate alloc] init];
        [delegate loadAreaData];
        ActionSheetCustomPicker *dataPicker =
        [UIView actionSheetCustomPickerWithTitle:@"请选择"
                                        delegate:delegate
                                          origin:self.view];
        [dataPicker showActionSheetPicker];
    }
    i++;
 */
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    DLog(@"selected date = %@", [selectedDate description]);
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
        [self setViewControllers:self.pagesArray[1]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:YES
                      completion:^(BOOL finished) {
                          //weakSelf.currentPageViewControllerIndex = 1;
                      }];
    }
}

#pragma mark - ActionSheetCustomPickerDelegate

- (void)actionSheetPicker:(AbstractActionSheetPicker *)actionSheetPicker
      configurePickerView:(UIPickerView *)pickerView {
}

/* Success callback */
- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin {
    
}

/* Cancel callback */
- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin {
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"刘希茜";
}
@end
