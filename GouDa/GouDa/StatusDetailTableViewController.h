//
//  StatusDetailTableViewController.h
//  GouDa
//
//  Created by 张威 on 15/9/27.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

//#import "BaseTableViewController.h"
#import "BaseViewController.h"
#import "Status.h"

@interface StatusDetailTableViewController : BaseViewController//BaseTableViewController

//@property (nonatomic, copy) NSString *statusID;
@property (nonatomic, strong) Status *status;

@end
