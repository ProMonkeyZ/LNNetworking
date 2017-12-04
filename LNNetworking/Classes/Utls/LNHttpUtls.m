//
//  LNHttpUtls.m
//  LNNetworking
//
//  Created by 张立宁 on 2017/12/2.
//

#import "LNHttpUtls.h"
#import "Networking.h"

@implementation LNHttpUtls

+ (LNCancelBlock)asyncGet:(NSString *)urlStr
                   params:(id)params
                 complete:(LNCompleteBlock)complete
                    faile:(LNFaileBlock)faile {
    __block NSURLSessionTask *task = nil;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        task = [Networking GET:urlStr params:params httpHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [self dealDataWithData:data
                       andResopnse:response
                          andError:error
                       andComplete:complete
                          andFaile:faile];
        }];
    }];
    
    return ^{
        if (task) {
            [task cancel];
        }
        [queue cancelAllOperations];
    };
}

+ (void)dealDataWithData:(NSData *)data
             andResopnse:(NSURLResponse *)response
                andError:(NSError *)error
             andComplete:(LNCompleteBlock)complete
                andFaile:(LNFaileBlock)faile {
    NSString *responseStr = nil;
    if (!error) {
        responseStr = [self parseNetData:data response:response];
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (responseStr) {
            if (complete) {
                complete(responseStr);
            }
            return ;
        }
        
        if (faile) {
            faile(error);
        }
    }];
}

+ (NSString *)parseNetData:(NSData *)data response:(NSURLResponse *)response {
    if (data) {
        NSStringEncoding stringEncoding = 0;
        NSString *textEncodingName = response.textEncodingName;
        if (textEncodingName != nil && ![textEncodingName isEqual:[NSNull null]]) {
            CFStringEncoding cfEncoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)textEncodingName);
            if (cfEncoding != kCFStringEncodingInvalidId) {
                stringEncoding = CFStringConvertEncodingToNSStringEncoding(cfEncoding);
            }
        }
        if (stringEncoding) {
            return [[NSString alloc] initWithData:data encoding:stringEncoding];
        }
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
