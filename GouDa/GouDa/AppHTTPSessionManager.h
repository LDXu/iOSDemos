//
//  AppHTTPSessionManager.h
//  APITest
//
//  Created by 张威 on 15/10/11.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AppHTTPSessionManager : AFHTTPSessionManager

- (instancetype)init __attribute__((unavailable("init not available")));

//- (instancetype)initWithBaseURL:(NSURL *)url __attribute__((unavailable("initWithBaseURL: not available")));

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration
__attribute__((unavailable("initWithSessionConfiguration: not available")));


+ (instancetype)sharedHTTPManager;

// send http post request
- (void)sendHTTPPostRequest:(NSString *)URLString
             withParameters:(NSDictionary *)parameters
                    success:(void (^)(NSDictionary *resultDic))success
                    failure:(void (^)(NSError *error))failure;

@end
