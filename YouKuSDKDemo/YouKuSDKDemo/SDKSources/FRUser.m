//
//  FRUser.m
//  YouKuSDKDemo
//
//  Created by Aidian.Tang on 15/3/10.
//  Copyright (c) 2015年 Aidian.Tang. All rights reserved.
//

#import "FRUser.h"

@implementation FRUser

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"identity" : @"id",
             };
}

@end
