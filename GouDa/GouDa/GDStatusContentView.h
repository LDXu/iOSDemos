//
//  GDStatusContentView.h
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/21.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDStatusContentView : UIView

// 宽度在auto layout中非常有用
//@property (nonatomic, assign) CGFloat maxWidth;

@property (nonatomic, assign) CGFloat preferredMaxLayoutWidth;

@property (nonatomic, copy) NSString *text;

- (void)prepareForReuse;

@end
