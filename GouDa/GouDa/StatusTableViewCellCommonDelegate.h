//
//  StatusTableViewCellCommonDelegate.h
//  GouDa
//
//  Created by 张威 on 15/10/18.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusTableViewCellDelegate.h"

@protocol StatusTableViewCellCommonDelegate <NSObject>

@property (nonatomic, strong) Status *status;

@property (nonatomic, assign) BOOL likeSelected;

@property (nonatomic, assign) BOOL hideBottomLine;
@property (nonatomic, assign) BOOL hideOperationButton;

@property (nonatomic, weak) id<StatusTableViewCellDelegate> delegate;

@end
