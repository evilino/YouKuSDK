//
//  FRVideo.h
//  YouKuSDKDemo
//
//  Created by Aidian.Tang on 15/3/10.
//  Copyright (c) 2015年 Aidian.Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRUser.h"

@interface FRVideo : NSObject

@property (nonatomic, copy) NSString *identity;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, strong) FRUser *user;

@end
