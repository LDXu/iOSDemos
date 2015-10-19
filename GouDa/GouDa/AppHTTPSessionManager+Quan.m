//
//  AppHTTPSessionManager+Quan.m
//  APITest
//
//  Created by 张威 on 15/10/11.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "AppHTTPSessionManager+Quan.h"

@implementation AppHTTPSessionManager (Quan)

- (void)publishMomentWithUserID:(NSString *)userID
                        content:(NSString *)content
                      imageURLs:(NSString *)imageURLs
                        success:(void (^)(NSDictionary *resultDic))success
                        failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{
                                 @"device": AppDeviceDescription,
                                 @"userid": userID ?: @"",
                                 @"content": content ?: @"",
                                 @"images": imageURLs ?: @""
                                 };
    
    [self sendHTTPPostRequest:@"group/add"
               withParameters:parameters
                      success:success
                      failure:failure];
}

- (void)likeStatusWithUserID:(NSString *)userID
                    statusID:(NSString *)statusID
                     success:(void (^)(NSDictionary *))success
                     failure:(void (^)(NSError *))failure {
    NSDictionary *parameters = @{
                                 @"device": AppDeviceDescription,
                                 @"userid": userID ?: @"",
                                 @"moment_id": statusID ?: @"",
                                 };
    
    [self sendHTTPPostRequest:@"group/like"
               withParameters:parameters
                      success:success
                      failure:failure];
}

- (void)cityWideStatusWithUserID:(NSString *)userID
                          cityID:(NSString *)cityID
                       pageIndex:(NSUInteger)pageIndex
                    countPerPage:(NSUInteger)countPerPage
                         success:(void (^)(NSDictionary *resultDic))success
                         failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{
                                 @"device": AppDeviceDescription,
                                 @"userid": userID ?: @"",
                                 @"cityid": cityID ?: @"",
                                 @"page": [NSNumber numberWithUnsignedInteger:pageIndex],
                                 @"num": [NSNumber numberWithUnsignedInteger:countPerPage]
                                 };
    
    [self sendHTTPPostRequest:@"group/citywide"
               withParameters:parameters
                      success:success
                      failure:failure];
}

- (void)hotStatusWithUserID:(NSString *)userID
                  pageIndex:(NSUInteger)pageIndex
               countPerPage:(NSUInteger)countPerPage
                    success:(void (^)(NSDictionary *))success
                    failure:(void (^)(NSError *))failure {

    NSDictionary *parameters = @{
                                 @"device": AppDeviceDescription,
                                 @"userid": userID ?: @"",
                                 @"page": [NSNumber numberWithUnsignedInteger:pageIndex],
                                 @"num": [NSNumber numberWithUnsignedInteger:countPerPage]
                                 };
    
    [self sendHTTPPostRequest:@"group/hot"
               withParameters:parameters
                      success:success
                      failure:failure];
}

- (void)followedStatusWithUserID:(NSString *)userID
                       pageIndex:(NSUInteger)pageIndex
                    countPerPage:(NSUInteger)countPerPage
                         success:(void (^)(NSDictionary *resultDic))success
                         failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{
                                 @"device": AppDeviceDescription,
                                 @"userid": userID ?: @"",
                                 @"page": [NSNumber numberWithUnsignedInteger:pageIndex],
                                 @"num": [NSNumber numberWithUnsignedInteger:countPerPage]
                                 };
    
    [self sendHTTPPostRequest:@"group/followed"
               withParameters:parameters
                      success:success
                      failure:failure];
}

- (void)statusDetailWithID:(NSString *)statusID
                   success:(void (^)(NSDictionary *resultDic))success
                   failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{
                                 @"device": AppDeviceDescription,
                                 @"moment_id": statusID ?: @"",
                                 };
    [self sendHTTPPostRequest:@"group/detail"
               withParameters:parameters
                      success:success
                      failure:failure];
}

- (void)replyStatusWithUserID:(NSString *)userID
                     statusID:(NSString *)statusID
                      content:(NSString *)content
                    repliedID:(NSString *)repliedID
                      success:(void (^)(NSDictionary *resultDic))success
                      failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{
                                 @"device": AppDeviceDescription,
                                 @"moment_id": statusID ?: @"",
                                 @"userid": userID ?: @"",
                                 @"content": content ?: @"",
                                 @"replied": repliedID ?: @"",
                                 };
    [self sendHTTPPostRequest:@"group/reply"
               withParameters:parameters
                      success:success
                      failure:failure];
}

- (void)statusReplyListWithID:(NSString *)statusID
                    pageIndex:(NSUInteger)pageIndex
                 countPerPage:(NSUInteger)countPerPage
                      success:(void (^)(NSDictionary *resultDic))success
                      failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{
                                 @"device": AppDeviceDescription,
                                 @"moment_id": statusID ?: @"",
                                 @"page": [NSNumber numberWithUnsignedInteger:pageIndex],
                                 @"num": [NSNumber numberWithUnsignedInteger:countPerPage]
                                 };
    [self sendHTTPPostRequest:@"group/replyList"
               withParameters:parameters
                      success:success
                      failure:failure];
}

@end
