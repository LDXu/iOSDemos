//
//  QuanStatusConfiguration.h
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#ifndef QuanStatusConfiguration_h
#define QuanStatusConfiguration_h

// avatar直径
#define kAvatarDiameter                 (40.f)
#define kSpacingBetweenAvatarAndContent (10.f)

// {top, left, bottom, right};
static UIEdgeInsets kQuanStatusCellEdgeInsets = {10.f, 10.f, 0.f, 10.f};

#define kStatusContentViewMarginRight          (20.f)

//#define kStatusContnetViewMarginTop     (4.f)
//#define kStatusContnetViewMarginBottom  (4.f)

#define kStatusAlbumViewMarginRight   kStatusContentViewMarginRight

// 「状态」发布者信息 view height
#define kPublisherInfoViewHeight        kAvatarDiameter

// 「状态」bottom view height
#define kStatusBottomViewHeight     (30.f)

// 「状态」bottom line height
#define kStatusBottomLineHeight     (1.f)

#endif /* QuanStatusConfiguration_h */
