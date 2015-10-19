//
//  UserInfo.m
//  HotChat                        
//
//  Created by ChenLi on 13-12-13.
//
//

#import "UserInfo.h"

@implementation UserInfo

/*
 @property (nonatomic, copy) NSString *userID;
 @property (nonatomic, copy) NSString *cityID;
 @property (nonatomic, copy) NSString *nick;
 @property (nonatomic, assign) NSUInteger *gender;
 */

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _userID = [dict objectForKey:@"userid"];
        _cityID = [dict objectForKey:@"cityid"];
        _nick   = [dict objectForKey:@"nickname"];
        _gender = [[dict objectForKey:@"sex"] integerValue];
    }
    return self;
}

/*
- (instancetype)initWithUserInfo:(UserInfo *)userInfo {
    self = [super init];
    if (self) {
        if (userInfo) {
            _userNickName      = [NSString stringWithString:userInfo.userNickName];
            _userGender        = [NSNumber numberWithInteger:userInfo.userGender.integerValue];
            _userInstID        = [NSString stringWithString:userInfo.userInstID];
            _userAvatarDict    = [NSDictionary dictionaryWithDictionary:userInfo.userAvatarDict];
            _address           = [NSString stringWithString:userInfo.address];
            _phoneNumberString = [NSString stringWithString:userInfo.phoneNumberString];
        }
    }
    return self;
}

- (void)updateUserAvatarWithDict:(NSDictionary *)imageDict {
    if ([imageDict isKindOfClass:[NSDictionary class]]) {
        _userAvatarDict = [imageDict copy];
    }
}
*/
@end
