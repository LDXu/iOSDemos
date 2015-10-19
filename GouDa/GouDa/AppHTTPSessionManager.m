//
//  AppHTTPSessionManager.m
//  APITest
//
//  Created by 张威 on 15/10/11.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "AppHTTPSessionManager.h"

@implementation AppHTTPSessionManager

//#define monitoringNetworking        // 监视网络数据

#ifdef monitoringNetworking
#define SLog DLog
#else
#define SLog(...)
#endif

// singleton
+ (instancetype)sharedHTTPManager {
    
    static AppHTTPSessionManager *_centeralServerManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 1. base url
        _centeralServerManager =
        [[AppHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:AppHTTPAPIBaseURLString]];
        
        // 2. encoding in utf8
        NSStringEncoding utf8Encoding =
        CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
        _centeralServerManager.requestSerializer.stringEncoding = utf8Encoding;
        
        // 3. supported content types
        _centeralServerManager.responseSerializer.acceptableContentTypes =
        [NSSet setWithObjects:@"application/x-www-form-urlencoded", @"application/json", @"text/html",  nil];
    });
    
    return _centeralServerManager;
}

- (void)sendHTTPPostRequest:(NSString *)URLString
             withParameters:(NSDictionary *)parameters
                   success:(void (^)(NSDictionary *resultDic))success
                   failure:(void (^)(NSError *error))failure {
    SLog(@"send HTTP POST request to url: %@", URLString);
    
    [self POST:URLString
    parameters:parameters
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
           
           SLog(@"response responseObject: %@", responseObject);
           
           if (![responseObject isKindOfClass:[NSDictionary class]]) {
               if (failure) {
                   failure([NSError errorWithDomain:AppHTTPResponseDomainDefault
                                               code:AppHTTPResponseCodeDefaultError
                                           userInfo:@{NSLocalizedDescriptionKey:@"服务器响应内容错误"}]);
               }
               DLog(@"服务器响应内容错误 = %@", responseObject);
           } else {
               NSInteger code = AppHTTPResponseCodeDefaultError;
               code = [[(NSDictionary *)responseObject objectForKey:@"code"] integerValue];
               if (code == AppHTTPResponseCodeSuccess) {
                   if (success) {
                       success(responseObject);
                   }
               } else {
                   if (failure) {
                       NSString *errorDetail = [(NSDictionary *)responseObject objectForKey:@"msg"];
                       if (errorDetail == nil || [errorDetail isEqualToString:@""]) {
                           errorDetail = @"服务器未定义错误";
                       }
                       failure([NSError errorWithDomain:AppHTTPResponseDomainDefault
                                                   code:code
                                               userInfo:@{NSLocalizedDescriptionKey:errorDetail}]);
                   }
               }
           }
       }
       failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
           SLog(@"HTTP Request Failed, Error: %@", error);
           if (failure) {
               failure(error);
           }
       }];
}

@end
