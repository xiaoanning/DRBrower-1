//
//  DRDataService.m
//  DRBrower
//
//  Created by QiQi on 2016/12/20.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "DRDataService.h"

@implementation DRDataService

+ (DRDataService *)sharedClient {
    static DRDataService *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DRDataService alloc] init];
    });
    _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/plain", nil];

    return _sharedClient;
}
- (NSURLSessionDataTask *)DR_get:(NSString *)URLString
                      parameters:(id)parameters
                      completion:(void (^)(id response, NSError *error, NSDictionary *header))completion {
    return [super GET:URLString
           parameters:parameters
             progress:^(NSProgress * _Nonnull downloadProgress) {
                 
             }
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  if (responseObject) {
                      completion(responseObject, nil, nil);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  completion(nil, error, nil);
                  NSLog(@"task.stase %ld",(long)task.state);
              }];
    
}
- (NSURLSessionDataTask *)DR_post:(NSString *)URLString
                       parameters:(id)parameters
                       completion:(void (^)(id response, NSError *error))completion {
    return [super POST:URLString
            parameters:parameters
              progress:^(NSProgress * _Nonnull uploadProgress) {
                  
              }
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if (responseObject) {
                       completion(responseObject, nil);
                   }
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   completion(nil, error);
                   NSLog(@"task.state %ld",(long)task.state);
               }];
    
}

@end
