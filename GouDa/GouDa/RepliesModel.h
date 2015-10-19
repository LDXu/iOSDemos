//
//  RepliesModel.h
//  GouDa
//
//  Created by 张威 on 15/10/17.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusReply.h"

@interface RepliesModel : NSObject

- (instancetype __nullable)init __attribute__((unavailable("init not available")));

- (instancetype __nonnull)initWithDictionary:(NSDictionary * __nullable)dict;

@property (nonatomic, assign, readonly) NSUInteger count;

- (StatusReply * __nullable)replyAtIndex:(NSUInteger)index;
- (StatusReply * __nullable)firstReply;

- (void)insertReply:(nonnull StatusReply *)reply atIndex:(NSUInteger)index;

@end
