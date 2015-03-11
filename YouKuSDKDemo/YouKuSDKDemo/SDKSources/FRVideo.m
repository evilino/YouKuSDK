//
//  FRVideo.m
//  YouKuSDKDemo
//
//  Created by Aidian.Tang on 15/3/10.
//  Copyright (c) 2015年 Aidian.Tang. All rights reserved.
//

#import "FRVideo.h"

@implementation FRVideo

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"identity" : @"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"user" : [FRUser class]
             };
}

@end
