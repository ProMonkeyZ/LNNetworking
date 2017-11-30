//
//  LNHttpRACUtls.h
//  LNNetworking
//
//  Created by 张立宁 on 2017/11/30.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface LNHttpRACUtls : NSObject

/**
 get 请求

 @param url 地址
 @param params 参数
 @return 信号
 */
+ (RACSignal *)GET:(NSString *)url params:(id)params;

/**
 post 请求
 
 @param url 地址
 @param params 参数
 @return 信号
 */
+ (RACSignal *)POST:(NSString *)url params:(id)params;

@end
