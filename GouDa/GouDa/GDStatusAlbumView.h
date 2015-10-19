//
//  GDStatusAlbumView.h
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/21.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GDStatusAlbumViewDeleagte;

@interface GDStatusAlbumView : UIView

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame not available")));

@property (nonatomic, copy) NSArray *photos;

// 宽度在auto layout中非常有用
@property (nonatomic, assign) CGFloat maxWidth;

@property (nonatomic, weak) id<GDStatusAlbumViewDeleagte> delegate;

- (void)prepareForReuse;

@end

@protocol GDStatusAlbumViewDeleagte <NSObject>

- (void)didTappedAlbumView:(GDStatusAlbumView *)albumView atIndex:(NSInteger)index;

@end
