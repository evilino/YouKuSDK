//
//  FRYouKuUtils.m
//  YouKuSDKDemo
//
//  Created by Aidian.Tang on 15/3/10.
//  Copyright (c) 2015年 Aidian.Tang. All rights reserved.
//

#import "FRYouKuUtils.h"
#import "AFNetworking.h"
#import "FRYouKuURLStatics.h"
#import "MJExtension.h"

typedef void(^FRYouKuUtilsRequestDataCompletion)(NSError *error, id JSON);

@interface FRYouKuUtils ()

@property (nonatomic, copy) NSString *clientID;

@end

@implementation FRYouKuUtils

+ (instancetype)sharedUtils
{
    static dispatch_once_t once;
    static FRYouKuUtils * singleton;
    dispatch_once(&once, ^ {
        singleton = [[FRYouKuUtils alloc] init];
    });
    return singleton;
}

+ (void)startWithClientID:(NSString *)clientID
{
    [FRYouKuUtils sharedUtils].clientID = clientID;
}

+ (void)requestWithURL:(NSString *)URL params:(NSDictionary *)params completion:(FRYouKuUtilsRequestDataCompletion)completion
{
    NSString *urlString = [NSString stringWithFormat:@"%@client_id=%@", URL, [FRYouKuUtils sharedUtils].clientID];
    if (params) {
        for (NSString *key in params.allKeys) {
            urlString = [NSString stringWithFormat:@"%@&%@=%@", urlString, key, [params objectForKey:key]];
        }
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:req success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        @try {
            if (completion) {
                completion(nil, JSON);
            }
        }
        @catch (NSException *exception) {
            
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (completion) {
            completion(error, nil);
        }
    }];
    
    [operation start];
}

#pragma mark -
#pragma mark - 搜索

+ (void)searchVideoWithTag:(NSString *)videoTag category:(NSString *)category period:(NSString *)period orderby:(NSString *)orderby page:(long)page pageCount:(long)pageCount completion:(FRYouKuUtilsRequestCompletion)completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (videoTag.length > 0) {
        [params setValue:videoTag forKey:@"tag"];
    }
    if (category.length > 0) {
        [params setValue:category forKey:@"category"];
    }
    if (period.length > 0) {
        [params setValue:period forKey:@"period"];
    }
    if (orderby.length > 0) {
        [params setValue:orderby forKey:@"orderby"];
    }
    if (page > 0) {
        [params setValue:[NSNumber numberWithLong:page] forKey:@"page"];
    }
    if (pageCount > 0) {
        [params setValue:[NSNumber numberWithLong:pageCount] forKey:@"count"];
    }
    
    [[self class] requestWithURL:FRSearchWithTagURL params:params completion:^(NSError *error, id JSON) {
        if (!error) {
            id videos = [JSON objectForKey:@"videos"];
            NSMutableArray *videoObjs = nil;
            if (videos && [videos isKindOfClass:[NSArray class]]) {
                videoObjs = [NSMutableArray array];
                for (NSDictionary *dataDic in videos) {
                    if ([dataDic isKindOfClass:[NSDictionary class]]) {
                        FRVideo *video = [FRVideo objectWithKeyValues:dataDic];
                        if (video) {
                            [videoObjs addObject:video];
                        }
                    }
                }
            }
            
            long total = [[JSON objectForKey:@"total"] longValue];
            BOOL hasNextPage = total > page * pageCount ? YES : NO;
            
            if (completion) {
                completion(hasNextPage , nil, videoObjs);
            }
        } else {
            completion(NO , error, nil);
        }
    }];
}

#pragma mark -
#pragma mark - 视频

+ (void)getVideosWithUserID:(NSString *)userID userName:(NSString *)userName orderby:(NSString *)orderby page:(long)page pageCount:(long)pageCount completion:(FRYouKuUtilsRequestCompletion)completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (userID.length > 0) {
        [params setValue:userID forKey:@"user_id"];
    }
    if (userName.length > 0) {
        [params setValue:userName forKey:@"user_name"];
    }
    if (orderby.length > 0) {
        [params setValue:orderby forKey:@"orderby"];
    }
    if (page > 0) {
        [params setValue:[NSNumber numberWithLong:page] forKey:@"page"];
    }
    if (pageCount > 0) {
        [params setValue:[NSNumber numberWithLong:pageCount] forKey:@"count"];
    }
    
    [[self class] requestWithURL:FRVideoWithUserURL params:params completion:^(NSError *error, id JSON) {
        if (!error) {
            id videos = [JSON objectForKey:@"videos"];
            NSMutableArray *videoObjs = nil;
            if (videos && [videos isKindOfClass:[NSArray class]]) {
                videoObjs = [NSMutableArray array];
                for (NSDictionary *dataDic in videos) {
                    if ([dataDic isKindOfClass:[NSDictionary class]]) {
                        FRVideo *video = [FRVideo objectWithKeyValues:dataDic];
                        if (video) {
                            [videoObjs addObject:video];
                        }
                    }
                }
            }
            
            long total = [[JSON objectForKey:@"total"] longValue];
            BOOL hasNextPage = total > page * pageCount ? YES : NO;
            
            if (completion) {
                completion(hasNextPage , nil, videoObjs);
            }
        } else {
            completion(NO , error, nil);
        }
    }];
}

@end
