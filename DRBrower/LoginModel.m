//
//  LoginModel.m
//  DRBrower
//
//  Created by apple on 2017/3/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

+(NSURLSessionDataTask *)getTelCodeUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}

+(NSURLSessionDataTask *)userRegsitUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}

+(NSURLSessionDataTask *)resetPasswordUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}

+(NSURLSessionDataTask *)userLoginUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}

+(NSURLSessionDataTask *)cancleLoginUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}
+(NSURLSessionDataTask *)getUserInfo:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}
@end
