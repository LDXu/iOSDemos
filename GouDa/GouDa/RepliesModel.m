//
//  RepliesModel.m
//  GouDa
//
//  Created by 张威 on 15/10/17.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "RepliesModel.h"

@interface RepliesModel ()

@property (nonatomic, strong) NSMutableArray<StatusReply *> *replyArray;

@end

@implementation RepliesModel

@dynamic count;

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        
        if (![dict isKindOfClass:[NSDictionary class]]) {
            DLog(@"服务器返回数据错误");
            return self;
        }
        
        NSArray *tempArray = [dict objectForKey:@"replies"];
        _replyArray = [NSMutableArray arrayWithCapacity:tempArray.count];
        for (NSDictionary *aDic in tempArray) {
            StatusReply *reply = [[StatusReply alloc] initWithDictionary:aDic];
            [_replyArray addObject:reply];
        }
    }
    return self;
}


#pragma mark - getters and setters

- (NSUInteger)count {
    return self.replyArray.count;
}

- (StatusReply * __nullable)replyAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self.replyArray objectAtIndex:index];
}

- (void)insertReply:(nonnull StatusReply *)reply atIndex:(NSUInteger)index {
    [self.replyArray insertObject:reply atIndex:index];
    
}

- (StatusReply * __nullable)firstReply {
    return [self.replyArray firstObject];
}

@end
