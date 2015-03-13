//
//  ViewController.m
//  YouKuSDKDemo
//
//  Created by Aidian.Tang on 15/3/10.
//  Copyright (c) 2015年 Aidian.Tang. All rights reserved.
//

#import "ViewController.h"
#import "FRYouKuUtils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
                        [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [FRYouKuUtils startWithClientID:@"0f9a62047cc27e82"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test:(id)sender {
    
//    [FRYouKuUtils searchVideoWithTag:@"大波" category:nil period:nil orderby:nil page:1 pageCount:1 completion:^(BOOL hasNextPage, NSError *error, NSArray *objs) {
//        
//    }];
    
    [FRYouKuUtils getVideosWithUserID:@"23444541" userName:nil orderby:nil page:1 pageCount:10 completion:^(BOOL hasNextPage, NSError *error, NSArray *objs) {
        
    }];
    
}


@end
