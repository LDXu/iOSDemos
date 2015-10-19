//
//  StatusWithMultiPhotosTableViewCell.h
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusTableViewCellDelegate.h"
#import "Status.h"

@interface StatusWithMultiPhotosTableViewCell : UITableViewCell

@property (nonatomic, strong) Status *status;

@property (nonatomic, weak) id<StatusTableViewCellDelegate> delegate;

@end
