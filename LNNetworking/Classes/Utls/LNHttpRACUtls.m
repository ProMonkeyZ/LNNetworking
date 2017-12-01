//
//  LNHttpRACUtls.m
//  LNNetworking
//
//  Created by 张立宁 on 2017/11/30.
//

#import "LNHttpRACUtls.h"
#import "LNNetStatusHelp.h"

@interface LNHttpRACUtls()

@end

@implementation LNHttpRACUtls

/**
 获取网络状态

 @return 信号
 */
+ (RACSignal *)fetchNetStatus {
    if ([[LNNetStatusHelp shareInstance] currentReachabilityStatus] == NotReachable) {
        NSError *error = [NSError errorWithDomain:@"com.zln.err" code:-1001 userInfo:@{@"errorInfo":@"无网络"}];
        return [RACSignal error:error];
    }
    return nil;
}

+ (RACSignal *)GET:(NSString *)url params:(id)params {
    RACSignal *signal = [self fetchNetStatus];
    if (!signal) {
        signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }
    return signal;
}

+ (RACSignal *)POST:(NSString *)url params:(id)params {
    RACSignal *signal = [self fetchNetStatus];
    if (!signal) {
        signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }
    return signal;
}

@end
