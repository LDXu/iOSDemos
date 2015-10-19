//
//  StatusTableViewCellDelegate.h
//  GouDa
//
//  Created by 张威 on 15/10/16.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol StatusTableViewCellDelegate <NSObject>

- (void)didSelectedLikeButtonInCell:(UITableViewCell *)tableViewCell;
- (void)didClickedReplyButtonInCell:(UITableViewCell *)tableViewCell;

@optional

//- (void)didTappedAlbumView:(GDStatusAlbumView *)albumView atIndex:(NSInteger)index;

- (void)didClickedOperationButtonInCell:(UITableViewCell *)tableViewCell;

@end
