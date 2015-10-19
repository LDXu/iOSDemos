//
//  AppHTTPSessionManager+User.h
//  APITest
//
//  Created by 张威 on 15/10/11.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "AppHTTPSessionManager.h"

@interface AppHTTPSessionManager (User)

/**
 *  登录
 *
 *  @param phone    应该在使用此接口前，对手机号进行合法性检验
 *  @param password 密码，不可为空，
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)loginWithPhone:(NSString *)phone
              password:(NSString *)password
               success:(void (^)(NSDictionary *resultDic))success
               failure:(void (^)(NSError *error))failure;

@end
