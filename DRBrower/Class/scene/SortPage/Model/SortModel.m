//
//  SortModel.m
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "SortModel.h"

@implementation SortModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sort_id" : @"id"
             };
}

+(NSURLSessionDataTask *)getSortListUrl:(NSString *)url
                              parameters:(NSDictionary *)parameters
                                   block:(void (^)(SortListModel *newsList,
                                                   NSError *error))completion{
    return [[DRDataService sharedClient] DR_get:url parameters:@{} completion:^(id response, NSError *error, NSDictionary *header) {
        SortListModel *sortList = [MTLJSONAdapter modelOfClass:[SortListModel class]
                                            fromJSONDictionary:response
                                                         error:&error];
        completion(sortList,error);
    }];
}

+(NSURLSessionDataTask *)addLoveUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}
+(NSURLSessionDataTask *)addComplainUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}

@end
