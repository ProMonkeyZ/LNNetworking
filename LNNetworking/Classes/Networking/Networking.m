//
//  Networking.m
//  LNNetworking
//
//  Created by 张立宁 on 2017/12/2.
//

#import "Networking.h"

@implementation Networking

+ (NSURLSessionTask *)GET:(NSString *)url
                   params:(id)params
              httpHandler:(httpHandler)handler {
    NSMutableURLRequest *request = nil;
    
    if ([params isKindOfClass:[NSDictionary class]]) {
        NSMutableString *urlString = [NSMutableString stringWithString:url];
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [urlString appendFormat:([url rangeOfString:@"?"].location == NSNotFound?@"?%@=%@":@"&%@=%@"),key,[NSString stringWithFormat:@"%@",obj]];
        }];
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    } else if ([params isKindOfClass:[NSData class]]) {
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        request.HTTPBody = params;
    }
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 30;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self taskCompleteHandler:handler
                          andData:data
                      andResponse:response
                         andError:error];
    }];
    if (handler) {
        [self taskResume:task];
    }
    return task;
}

+ (NSURLSessionTask *)POST:(NSString *)url
                    params:(id)params
               httpHandler:(httpHandler)handler {
    NSMutableURLRequest *request = nil;
    
    if ([params isKindOfClass:[NSDictionary class]]) {
        NSMutableString *urlString = [NSMutableString stringWithString:url];
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [urlString appendFormat:([url rangeOfString:@"?"].location == NSNotFound?@"?%@=%@":@"&%@=%@"),key,[NSString stringWithFormat:@"%@",obj]];
        }];
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    } else if ([params isKindOfClass:[NSData class]]) {
        request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    }
    request.HTTPMethod = @"POST";\
    request.timeoutInterval = 30;
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self taskCompleteHandler:handler
                          andData:data
                      andResponse:response
                         andError:error];
    }];
    if (handler) {
        [self taskResume:task];
    }
    
    return task;
}

+ (void)taskResume:(NSURLSessionTask *)task {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }];
    [task resume];
}

+ (void)taskCompleteHandler:(httpHandler)handler
                    andData:(NSData *)data
                andResponse:(NSURLResponse *)response
                   andError:(NSError *)error {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    if (handler) {
        handler(data,response,error);
    }
}

@end
