//
//  LNViewController.m
//  LNNetworking
//
//  Created by 18333675676@163.com on 11/30/2017.
//  Copyright (c) 2017 18333675676@163.com. All rights reserved.
//

#import "LNViewController.h"
#import "LNNetworking.h"

/** 和风天气中国节点接口地址 */
static NSString *kApi  = @"https://free-api.heweather.com";
static NSString *kPrivatyKey = @"e319f866c39a43a196ab1f00b2399e4c";

@interface LNViewController ()

@end

@implementation LNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self getData];
}

- (void)getData {
    NSString *url = [kApi stringByAppendingString:@"/s6/weather/now"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"beijing" forKey:@"location"];
    [params setValue:kPrivatyKey forKey:@"key"];
    
    [[LNHttpRACUtls GET:url params:params] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

@end
