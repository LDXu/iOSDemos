//
//  AppHTTPSessionManager+User.m
//  APITest
//
//  Created by 张威 on 15/10/11.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "AppHTTPSessionManager+User.h"

@implementation AppHTTPSessionManager (User)

- (void)loginWithPhone:(NSString *)phone
              password:(NSString *)password
               success:(void (^)(NSDictionary *resultDic))success
               failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = @{
                                 @"device": AppDeviceDescription,
                                 @"phone": phone ?: @"",
                                 @"password": password ?: @""
                                 };
    
    [self sendHTTPPostRequest:@"user/login"
               withParameters:parameters
                      success:^(NSDictionary *resultDic) {
                          if (success) {
                              success(resultDic);
                          }
                      }
                      failure:^(NSError *error) {
                          if (failure) {
                              failure(error);
                          }
                      }];
    
}

@end
