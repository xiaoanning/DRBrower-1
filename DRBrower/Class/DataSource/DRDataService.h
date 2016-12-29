//
//  DRDataService.h
//  DRBrower
//
//  Created by QiQi on 2016/12/20.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface DRDataService : AFHTTPSessionManager

+ (DRDataService *)sharedClient;
- (NSURLSessionDataTask *)DR_get:(NSString *)URLString
                      parameters:(id)parameters
                      completion:(void (^)(id response, NSError *error, NSDictionary *header))completion;
- (NSURLSessionDataTask *)DR_post:(NSString *)URLString
                       parameters:(id)parameters
                       completion:(void (^)(id response, NSError *error))completion;

@end
