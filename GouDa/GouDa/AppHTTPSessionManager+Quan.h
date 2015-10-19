//
//  AppHTTPSessionManager+Quan.h
//  APITest
//
//  Created by 张威 on 15/10/11.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "AppHTTPSessionManager.h"

@interface AppHTTPSessionManager (Quan)

/**
 *  添加动态
 *
 *  @param userID    用户UserID
 *  @param content   动态内容，应该有字数限制
 *  @param imageURLs 图片URL列表，','隔开
 *  @param success   success block
 *  @param failure   failure block
 */
- (void)publishMomentWithUserID:(NSString *)userID
                        content:(NSString *)content
                      imageURLs:(NSString *)imageURLs
                        success:(void (^)(NSDictionary *resultDic))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  给「动态」点赞
 *
 *  @param userID   用户UserID
 *  @param statusID 动态ID
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)likeStatusWithUserID:(NSString *)userID
                    statusID:(NSString *)statusID
                     success:(void (^)(NSDictionary *resultDic))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  评论「动态」
 *
 *  @param userID    用户User ID
 *  @param statusID  动态ID
 *  @param content   评论内容，应该有字数限制
 *  @param repliedID 被评论的人的ID
 *  @param success   success block
 *  @param failure   failure block
 */
- (void)replyStatusWithUserID:(NSString *)userID
                     statusID:(NSString *)statusID
                      content:(NSString *)content
                    repliedID:(NSString *)repliedID
                      success:(void (^)(NSDictionary *resultDic))success
                      failure:(void (^)(NSError *error))failure;

/**
 *  「城市周边」「动态」
 *
 *  @param userID       字符
 *  @param cityID       字符
 *  @param pageIndex    从0开始
 *  @param countPerPage 每页item个数
 *  @param success      success block
 *  @param failure      failure block
 */
- (void)cityWideStatusWithUserID:(NSString *)userID
                          cityID:(NSString *)cityID
                       pageIndex:(NSUInteger)pageIndex
                    countPerPage:(NSUInteger)countPerPage
                         success:(void (^)(NSDictionary *resultDic))success
                         failure:(void (^)(NSError *error))failure;

/**
 *  获取「热门动态」
 *
 *  @param userID       字符
 *  @param pageIndex    从0开始
 *  @param countPerPage 每页item个数
 *  @param success      success block
 *  @param failure      failure block
 */
- (void)hotStatusWithUserID:(NSString *)userID
                  pageIndex:(NSUInteger)pageIndex
               countPerPage:(NSUInteger)countPerPage
                    success:(void (^)(NSDictionary *resultDic))success
                    failure:(void (^)(NSError *error))failure;

/**
 *  我「关注的人」的「动态」
 *
 *  @param userID       字符
 *  @param pageIndex    从0开始
 *  @param countPerPage 每页item个数
 *  @param success      success block
 *  @param failure      failure block
 */
- (void)followedStatusWithUserID:(NSString *)userID
                       pageIndex:(NSUInteger)pageIndex
                    countPerPage:(NSUInteger)countPerPage
                         success:(void (^)(NSDictionary *resultDic))success
                         failure:(void (^)(NSError *error))failure;

/**
 *  获取「动态详情」
 *
 *  @param statusID 动态ID
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)statusDetailWithID:(NSString *)statusID
                   success:(void (^)(NSDictionary *resultDic))success
                   failure:(void (^)(NSError *error))failure;

/**
 *  获取「动态评论列表」
 *
 *  @param statusID     字符
 *  @param pageIndex    从0开始
 *  @param countPerPage 每页item个数
 *  @param success      success block
 *  @param failure      failure block
 */
- (void)statusReplyListWithID:(NSString *)statusID
                    pageIndex:(NSUInteger)pageIndex
                 countPerPage:(NSUInteger)countPerPage
                      success:(void (^)(NSDictionary *resultDic))success
                      failure:(void (^)(NSError *error))failure;

@end
