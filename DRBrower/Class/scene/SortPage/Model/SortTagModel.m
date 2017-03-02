//
//  SortModel.m
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "SortTagModel.h"

@implementation SortTagModel
+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+(NSURLSessionDataTask *)getSortTagUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(SortTagListModel *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:@{} completion:^(id response, NSError *error, NSDictionary *header) {
        SortTagListModel *sortList = [MTLJSONAdapter modelOfClass:[SortTagListModel class]
                                               fromJSONDictionary:response
                                                            error:&error];
        completion(sortList,error);
    }];
}

@end
