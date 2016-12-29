//
//  NewsTagModel.m
//  DRBrower
//
//  Created by QiQi on 2016/12/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "NewsTagModel.h"


@implementation NewsTagModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tagId" : @"id"
             };
}

+ (NSURLSessionDataTask *)getNewsTagUrl:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                  block:(void (^)(NewsTagListModel *, NSError *))completion {
    NSLog(@"%@",url);
    return [[DRDataService sharedClient] DR_get:url
                                     parameters:@{}
                                     completion:^(id response, NSError *error, NSDictionary *header) {
                                         NewsTagListModel *tagList =
                                         [MTLJSONAdapter modelOfClass:[NewsTagListModel class]
                                                   fromJSONDictionary:response
                                                                error:&error];
                                         completion(tagList, error);
                                     }];
}

@end
