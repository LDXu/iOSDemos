//
//  Status.h
//  GouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusReply.h"

@interface Status : NSObject

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

@property (nonatomic, copy) NSString *publisherID;
@property (nonatomic, copy) NSString *publisherNick;
@property (nonatomic, copy) NSString *publisherAvatarURLString;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSArray<NSString *> *imageURLArray;

@property (nonatomic, copy) NSString *timeString;

@property (nonatomic, assign) NSUInteger replies;
@property (nonatomic, assign) NSUInteger likes;

@property (nonatomic, copy) NSString *statusID;

@property (nonatomic, assign) BOOL liked;

//@property (nonatomic, copy) NSArray <StatusReply *> *statusReplies;

- (StatusReply *)statusReplyAtIndex:(NSUInteger)index;
//- (NSUInteger)countOfStatusReplies;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
