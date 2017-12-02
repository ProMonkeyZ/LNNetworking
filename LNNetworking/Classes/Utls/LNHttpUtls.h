//
//  LNHttpUtls.h
//  LNNetworking
//
//  Created by 张立宁 on 2017/12/2.
//

#import <Foundation/Foundation.h>

typedef void(^LNCompleteBlock)(NSString *response);
typedef void(^LNFaileBlock)(NSError *error);
typedef void(^LNCancelBlock)(void);

@interface LNHttpUtls : NSObject

+ (LNCancelBlock)asyncGet:(NSString *)urlStr
                   params:(id)params
                 complete:(LNCompleteBlock)complete
                    faile:(LNFaileBlock)faile;

+ (LNCancelBlock)asyncPost:(NSString *)urlStr
                    params:(id)params
                  complete:(LNCompleteBlock)complete
                     faile:(LNFaileBlock)faile;

@end
