//
//  ZWSegmentedControl.m
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/18.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import "ZWSegmentedControl.h"

@interface ZWSegmentedControl ()

@property (nonatomic, strong) NSMutableArray *segmentItems;

@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation ZWSegmentedControl {
    SEL _segmentActionHandler;
    __weak id _target;
}


- (instancetype)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        _selectedSegmentIndex = -1;
        _segmentItems = [[NSMutableArray alloc] initWithCapacity:items.count];
        
        for (NSString *title in items) {
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button addTarget:self
                       action:@selector(segmentedButtonClicked:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [_segmentItems addObject:button];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)segmentedButtonClicked:(UIButton *)sender {
    if (sender != self.selectedButton) {
        UIButton *preSelectedItem = self.selectedButton;
        preSelectedItem.backgroundColor = [UIColor clearColor];
        [preSelectedItem setTitleColor:self.tintColor
                  forState:UIControlStateNormal];
        
        self.selectedButton = sender;
        
        NSInteger index = [self.segmentItems indexOfObject:sender];
        self.selectedSegmentIndex = index;
        
        self.selectedButton.backgroundColor = self.tintColor;
        [self.selectedButton setTitleColor:self.backgroundColor
                  forState:UIControlStateNormal];
    }
    [_target performSelector:_segmentActionHandler withObject:self afterDelay:0.0];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    if (_selectedSegmentIndex == selectedSegmentIndex || selectedSegmentIndex >= self.segmentItems.count) {
        return;
    }
    
    _selectedSegmentIndex = selectedSegmentIndex;
    
    UIButton *preSelectedItem = self.selectedButton;
    preSelectedItem.backgroundColor = [UIColor clearColor];
    [preSelectedItem setTitleColor:self.tintColor
                          forState:UIControlStateNormal];
    
    self.selectedButton = self.segmentItems[_selectedSegmentIndex];
    
    self.selectedButton.backgroundColor = self.tintColor;
    [self.selectedButton setTitleColor:self.backgroundColor
                              forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.cornerRadius;
    
    CGFloat buttonWidth = 0.f;
    if (self.segmentItems.count > 0) {
        buttonWidth = self.frame.size.width / self.segmentItems.count;
    }
    
    CGFloat offsetX = 0.f;
    for (int i = 0; i < self.segmentItems.count; ++i) {
        UIButton *button = self.segmentItems[i];
        button.frame = CGRectMake(offsetX, 0, buttonWidth, self.frame.size.height);
        button.layer.cornerRadius = self.cornerRadius;
        offsetX += buttonWidth;
    }
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    _target = target;
    _segmentActionHandler = action;
}

@end
