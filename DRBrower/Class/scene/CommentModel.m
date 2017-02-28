//
//  CommentModel.m
//  DRBrower
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"comment_id" : @"id"
             };
}

+(NSURLSessionDataTask *)getCommentListUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(CommentListModel *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        CommentListModel *commentListModel = [MTLJSONAdapter modelOfClass:[CommentListModel class] fromJSONDictionary:[response objectForKey:@"info"] error:&error];
        completion(commentListModel,error);
    }];
}
+(NSURLSessionDataTask *)addCommentUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}
@end
