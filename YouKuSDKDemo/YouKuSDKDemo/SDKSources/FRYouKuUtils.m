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

#pragma mark -
#pragma mark - 搜索

+ (void)searchVideoWithTag:(NSString *)videoTag category:(NSString *)category period:(NSString *)period orderby:(NSString *)orderby page:(long)page pageCount:(long)pageCount completion:(FRYouKuUtilsRequestCompletion)completion
{
    NSString *urlString=[NSString stringWithFormat:@"%@client_id=%@&tag=%@&category=%@&period=%@&orderby=%@&page=%ld&count=%ld", FRSearchWithTagURL, [FRYouKuUtils sharedUtils].clientID, videoTag, category, period, orderby, page, pageCount];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:req success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        @try {
            NSLog(@"JSON = %@", JSON);
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
            if (completion) {
                completion(nil, videoObjs);
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
#pragma mark - 视频

+ (void)getVideosWithUserID:(NSString *)userID userName:(NSString *)userName orderby:(NSString *)orderby page:(long)page pageCount:(long)pageCount completion:(FRYouKuUtilsRequestCompletion)completion
{
    
}

@end
