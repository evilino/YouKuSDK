//
//  FRYouKuUtils.h
//  YouKuSDKDemo
//
//  Created by Aidian.Tang on 15/3/10.
//  Copyright (c) 2015年 Aidian.Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRVideo.h"

typedef void(^FRYouKuUtilsRequestCompletion)(NSError *error, NSArray *objs);

@interface FRYouKuUtils : NSObject

/**
 *  配置客户端ID
 *
 *  @param clientID 注册开放平台，创建的App客户端ID
 */
+ (void)startWithClientID:(NSString *)clientID;

/**
 *  通过标签来搜索视频
 *
 *  @param videoTag  标签， 多个标签逗号分隔
 *  @param category  分类， 综艺 娱乐 教育 旅游 时尚 母婴 资讯 原创 女性 搞笑 音乐 电影 电视剧 体育 游戏 动漫 广告 生活 汽车 科技 其他
 *  @param period    时间范围， today: 今日 week: 本周 month: 本月 history: 历史
 *  @param orderby   排序， published: 发布时间 view-count: 总播放数 comment-count: 总评论数 reference-count: 总引用数 favorite-count: 总收藏数 relevance: 相关度
 *  @param page      页数
 *  @param pageCount 页大小
 *
 *  @return 包含视频对象（FRVideo）的数组
 */
+ (void)searchVideoWithTag:(NSString *)videoTag category:(NSString *)category period:(NSString *)period orderby:(NSString *)orderby page:(long)page pageCount:(long)pageCount completion:(FRYouKuUtilsRequestCompletion)completion;

/**
 *  获取用户上传的视频
 *
 *  @param userID    用户ID
 *  @param userName  用户名称
 *  @param orderby   排序， published: 发布时间 view-count: 总播放数 comment-count: 总评论数 reference-count: 总引用数 favorite-count: 总收藏数 relevance: 相关度
 *  @param page      页数
 *  @param pageCount 页大小
 *
 *  @return 包含视频对象（FRVideo）的数组
 */
+ (void)getVideosWithUserID:(NSString *)userID userName:(NSString *)userName orderby:(NSString *)orderby page:(long)page pageCount:(long)pageCount completion:(FRYouKuUtilsRequestCompletion)completion;

@end
