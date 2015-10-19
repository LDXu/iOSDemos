//
//  StatusReply.h
//  GouDa
//
//  Created by 张威 on 15/10/17.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@interface StatusReply : NSObject

@property (nonatomic, copy, readonly) NSString *replyID;
@property (nonatomic, copy, readonly) NSString *content;

@property (nonatomic, copy, readonly) NSString *senderID;
@property (nonatomic, copy, readonly) NSString *senderNick;
@property (nonatomic, copy, readonly) NSString *senderAvatarURLString;

@property (nonatomic, copy, readonly) NSString *repliedID;
@property (nonatomic, copy, readonly) NSString *repliedNick;

@property (nonatomic, copy, readonly) NSString *timeString;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (instancetype)initWithID:(NSString *)replyID
                   content:(NSString *)content
                   senerID:(NSString *)sendrID
                senderNick:(NSString *)senderNick
     senderAvatarURLString:(NSString *)senderAvatarURLString
                 repliedID:(NSString *)repliedID
               repliedNick:(NSString *)repliedNick
                timeString:(NSString *)timeString;
@end
