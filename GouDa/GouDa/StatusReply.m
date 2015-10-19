//
//  StatusReply.m
//  GouDa
//
//  Created by 张威 on 15/10/17.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "StatusReply.h"

/*
 "reply_id": 0,
 "content": "string",
 "sender_id": 0,
 "sender_name": "string",
 "sender_logo": "string",
 "replied_id": 0,
 "replied_name": "string",
 "time": "string"
 */

@interface StatusReply ()

@property (nonatomic, copy) NSString *replyID;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *senderID;
@property (nonatomic, copy) NSString *senderNick;
@property (nonatomic, copy) NSString *senderAvatarURLString;

@property (nonatomic, copy) NSString *repliedID;
@property (nonatomic, copy) NSString *repliedNick;

@property (nonatomic, copy) NSString *timeString;

@end
@implementation StatusReply

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (![dict isKindOfClass:[NSDictionary class]]) {
            return self;
        }
        
        _replyID               = [[dict objectForKey:@"reply_id"] copy];
        _content               = [[dict objectForKey:@"content"] copy];
        _senderID              = [[dict objectForKey:@"sender_id"] copy];
        _senderNick            = [[dict objectForKey:@"sender_name"] copy];
        _senderAvatarURLString = [[dict objectForKey:@"sender_logo"] copy];
        _repliedID             = [[dict objectForKey:@"replied_id"] copy];
        _repliedNick           = [[dict objectForKey:@"replied_name"] copy];
        _timeString            = [[dict objectForKey:@"time"] copy];
    }
    return self;
}

- (instancetype)initWithID:(NSString *)replyID
                   content:(NSString *)content
                   senerID:(NSString *)sendrID
                senderNick:(NSString *)senderNick
     senderAvatarURLString:(NSString *)senderAvatarURLString
                 repliedID:(NSString *)repliedID
               repliedNick:(NSString *)repliedNick
                timeString:(NSString *)timeString {
    
    self = [super init];
    if (self) {
        _replyID               = [replyID copy];
        _content               = [content copy];
        _senderID              = [sendrID copy];
        _senderNick            = [senderNick copy];
        _senderAvatarURLString = [senderAvatarURLString copy];
        _repliedID             = [repliedID copy];
        _repliedNick           = [repliedNick copy];
        _timeString            = [timeString copy];
    }
    return self;
}

@end
