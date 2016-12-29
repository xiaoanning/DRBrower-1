//
//  NewsModel.m
//  DRBrower
//
//  Created by QiQi on 2016/12/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "NewsModel.h"
#import "imgsModel.h"

@implementation NewsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

+ (NSValueTransformer *)imgsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[ImgsModel class]];
}

+ (NSURLSessionDataTask *)getNewsByTagUrl:(NSString *)url
                               parameters:(NSDictionary *)parameters
                                    block:(void (^)(NewsListModel *, NSError *))completion {
    NSLog(@"%@",url);
    return [[DRDataService sharedClient] DR_get:url
                                     parameters:parameters
                                     completion:^(id response, NSError *error, NSDictionary *header) {
                                        NewsListModel *newsList =
                                         [MTLJSONAdapter modelOfClass:[NewsListModel class]
                                                   fromJSONDictionary:response
                                                                error:&error];
                                         completion(newsList, error);
                                         
                                     }];
}
@end
