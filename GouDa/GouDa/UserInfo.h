//
//  UserInfo.h
//  HotChat
//
//  Created by ChenLi on 13-12-13.
//
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *cityID;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, copy) NSString *avatarURLString;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
//- (instancetype)initWithUserInfo:(UserInfo *)userInfo;
// 更新头像
//- (void)updateUserAvatarWithDict:(NSDictionary *)imageDict;

@end
