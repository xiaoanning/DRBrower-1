//
//  AdviceModel.m
//  DRBrower
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "AdviceModel.h"

@implementation AdviceModel

+(NSURLSessionDataTask *)addAdviceUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}

@end
