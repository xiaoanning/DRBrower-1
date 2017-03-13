//
//  HotWordModel.m
//  DRBrower
//
//  Created by QiQi on 2017/3/12.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "HotWordModel.h"

@implementation HotWordModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSURLSessionDataTask *)getHotWordUrl:(NSString *)url
                               parameters:(NSDictionary *)parameters
                                  block:(void (^)(HotWordModel *, NSError *))completion {
    NSLog(@"%@",url);
    return [[DRDataService sharedClient] DR_get:url
                                     parameters:parameters
                                     completion:^(id response, NSError *error, NSDictionary *header) {
                                         HotWordModel *list =
                                         [MTLJSONAdapter modelOfClass:[HotWordModel class] fromJSONDictionary:response[@"data"] error:&error];
                                         completion(list, error);
                                         
                                     }];
}


@end
