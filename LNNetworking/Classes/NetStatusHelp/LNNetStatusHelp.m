//
//  LNNetStatusHelp.m
//  LNNetworking
//
//  Created by 张立宁 on 2017/11/30.
//

#import "LNNetStatusHelp.h"
#import "Reachability.h"

@interface LNNetStatusHelp()

@property (nonatomic, strong) Reachability *netStatusHelp;

@end

@implementation LNNetStatusHelp

+ (instancetype)shareInstance {
    static LNNetStatusHelp *statusHelp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        statusHelp = [[LNNetStatusHelp alloc] init];
    });
    return statusHelp;
}

- (instancetype)init {
    if (self = [super init]) {
        self.netStatusHelp = [Reachability reachabilityForInternetConnection];
    }
    return self;
}

- (NetworkStatus)currentReachabilityStatus {
    return [self.netStatusHelp currentReachabilityStatus];
}

@end
