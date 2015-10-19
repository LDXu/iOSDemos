//
//  Status.m
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "Status.h"
#import "NSString+App.h"

@implementation Status {
    NSMutableArray<StatusReply *> *_statusReplies;
}

/*
 publisher_id	String
 content         String
 time            String
 images          String
 reply_num       String
 moment_id       String
 userlogo        String
 likes_num       String
 publisher_name	String
 */

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (![dict isKindOfClass:[NSDictionary class]]) {
            return self;
        }
        
        _publisherID              = [[dict objectForKey:@"publisher_id"] copy];
        _publisherNick            = [[dict objectForKey:@"publisher_name"] copy];
        _publisherAvatarURLString = [[dict objectForKey:@"userlogo"] copy];

        _content = [[dict objectForKey:@"content"] copy];
        
        NSString *temp = [[dict objectForKey:@"images"] copy];
        _imageURLArray = [NSString splitStringToArray:temp withSeperator:@","];

        _timeString = [[dict objectForKey:@"time"] copy];

        // 「评论」数
        temp = [dict objectForKey:@"reply_num"];
        if ([NSString isPureInt:temp]) {
            _replies = temp.integerValue;
        } else {
            DLog(@"Status类型initWithDictionary:方法报告：服务器返回数据错误");
            _replies = 0;
        }
        
        // 「赞」数
        temp = [dict objectForKey:@"likes_num"];
        if ([NSString isPureInt:temp]) {
            _likes = temp.integerValue;
        } else {
            DLog(@"Status类型initWithDictionary:方法报告：服务器返回数据错误");
            _likes = 0;
        }
        
        _statusID = [dict objectForKey:@"moment_id"];
        
        // 评论详情
        /*
        NSArray *tempArray = [dict objectForKey:@"reply"];
        _statusReplies     = [NSMutableArray arrayWithCapacity:tempArray.count];

        // 评论数（以实际评论数为准）
        if (tempArray.count > 0) {
            _replies = tempArray.count;
        }

        for (NSDictionary *aDic in tempArray) {
            StatusReply *statusReply = [[StatusReply alloc] initWithDictionary:aDic];
            [_statusReplies addObject:statusReply];
        }
         */
        
        // 「我」是否点过赞
        temp = [dict objectForKey:@"liked"];
        _liked = temp.boolValue;
    }
    return self;
}

- (StatusReply * __nullable)statusReplyAtIndex:(NSUInteger)index {
    if (index >= _statusReplies.count) {
        return nil;
    }
    return [_statusReplies objectAtIndex:index];
}
/*
- (NSUInteger)countOfStatusReplies {
    return _statusReplies.count;
}
 */

@end
