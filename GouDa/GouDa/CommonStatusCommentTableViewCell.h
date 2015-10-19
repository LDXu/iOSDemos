//
//  CommonStatusCommentTableViewCell.h
//  GouDa
//
//  Created by 张威 on 15/9/27.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonStatusCommentTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *nickString;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, assign) BOOL showTopLine;

@end
