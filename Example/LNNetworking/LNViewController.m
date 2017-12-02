//
//  LNViewController.m
//  LNNetworking
//
//  Created by 18333675676@163.com on 11/30/2017.
//  Copyright (c) 2017 18333675676@163.com. All rights reserved.
//

#import "LNViewController.h"
#import "LNNetworking.h"

@interface LNViewController ()

@end

@implementation LNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[LNHttpRACUtls GET:@"" params:@[]] subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
