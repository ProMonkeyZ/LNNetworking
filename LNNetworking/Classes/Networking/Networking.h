//
//  Networking.h
//  LNNetworking
//
//  Created by 张立宁 on 2017/12/2.
//

#import <Foundation/Foundation.h>

typedef void(^httpHandler)(NSData *data, NSURLResponse *response, NSError *error);

@interface Networking : NSObject

+ (NSURLSessionTask *)GET:(NSString *)url
                   params:(id)params
              httpHandler:(httpHandler)handler;

+ (NSURLSessionTask *)POST:(NSString *)url
                    params:(id)params
               httpHandler:(httpHandler)handler;

@end
