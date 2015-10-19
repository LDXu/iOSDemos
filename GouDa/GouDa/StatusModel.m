//
//  StatusModel.m
//  GouDa
//
//  Created by 张威 on 15/10/16.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "StatusModel.h"

@interface StatusModel ()

@property (nonatomic, strong) NSMutableArray<Status *> *statusArray;

@end

@implementation StatusModel

@dynamic count;

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        
        if (![dict isKindOfClass:[NSDictionary class]]) {
            DLog(@"服务器返回数据错误");
            return self;
        }
        
        NSArray *tempArray = [dict objectForKey:@"moments"];
        _statusArray = [NSMutableArray arrayWithCapacity:tempArray.count];
        for (NSDictionary *aDic in tempArray) {
            Status *status = [[Status alloc] initWithDictionary:aDic];
            [_statusArray addObject:status];
        }
    }
    return self;
}


#pragma mark - getters and setters

- (NSUInteger)count {
    return self.statusArray.count;
}

- (Status * __nullable)statusAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self.statusArray objectAtIndex:index];
}

@end
