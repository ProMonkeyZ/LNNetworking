//
//  LNNetStatusHelp.h
//  LNNetworking
//
//  Created by 张立宁 on 2017/11/30.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface LNNetStatusHelp : NSObject

+ (instancetype)shareInstance;

/**
 当前网络状态 :{
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
 }
 @return 状态枚举
 */
- (NetworkStatus)currentReachabilityStatus;

@end
