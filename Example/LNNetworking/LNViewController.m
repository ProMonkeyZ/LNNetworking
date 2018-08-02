//
//  LNViewController.m
//  LNNetworking
//
//  Created by 18333675676@163.com on 11/30/2017.
//  Copyright (c) 2017 18333675676@163.com. All rights reserved.
//

#import "LNViewController.h"
#import "LNNetworking.h"
#import "Networking.h"

/** 和风天气中国节点接口地址 */
static NSString *kApi  = @"https://free-api.heweather.com";
static NSString *kPrivatyKey = @"e319f866c39a43a196ab1f00b2399e4c";

typedef void(^voidBlock)(void);

@interface LNViewController ()

@end

@implementation LNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self getData];
}

- (void)getData {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSLog(@"1执行");
    [self requestOneWithSuccessBlock:^{
        NSLog(@"1结束");
        dispatch_semaphore_signal(semaphore);
    }];
    
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSLog(@"2执行");
    [self requestTwoWithBlock:^{
        NSLog(@"2结束");
    }];
    
    NSLog(@"主线程执行");
    
    
}

- (void)requestOneWithSuccessBlock:(voidBlock)block {
    NSString *url = [kApi stringByAppendingString:@"/s6/weather/now"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"beijing" forKey:@"location"];
    [params setValue:kPrivatyKey forKey:@"key"];
    
    [[LNHttpRACUtls GET:url params:params] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        block();
    } error:^(NSError * _Nullable error) {
        block();
    }];
}

- (void)requestTwoWithBlock:(voidBlock)block {
    NSString *url = [kApi stringByAppendingString:@"/s6/weather/now"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"beijing" forKey:@"location"];
    [params setValue:kPrivatyKey forKey:@"key"];
    
    [[LNHttpRACUtls GET:url params:params] subscribeNext:^(id  _Nullable x) {
        block();
    } error:^(NSError * _Nullable error) {
        block();
    }];
}

@end
