//
//  StatusWithoutPhotoTableViewCell.h
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "StatusTableViewCellCommonDelegate.h"
#import "StatusTableViewCellDelegate.h"

@interface StatusWithoutPhotoTableViewCell : UITableViewCell <StatusTableViewCellCommonDelegate>

@property (nonatomic, strong) Status *status;

@property (nonatomic, weak) id<StatusTableViewCellDelegate> delegate;

@property (nonatomic, assign) BOOL likeSelected;

@property (nonatomic, assign) BOOL hideBottomLine;
@property (nonatomic, assign) BOOL hideOperationButton;

@end
