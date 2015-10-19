//
//  StatusModel.h
//  GouDa
//
//  Created by 张威 on 15/10/16.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"

@interface StatusModel : NSObject

- (instancetype __nullable)init __attribute__((unavailable("init not available")));

- (instancetype __nonnull)initWithDictionary:(NSDictionary * __nullable)dict;

@property (nonatomic, assign, readonly) NSUInteger count;

- (Status * __nullable)statusAtIndex:(NSUInteger)index;

@end
