//
//  LoginModel.h
//  DRBrower
//
//  Created by apple on 2017/3/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
//获取验证码
+ (NSURLSessionDataTask *)getTelCodeUrl:(NSString *)url
                            parameters:(NSDictionary *)parameters
                                 block:(void (^)(NSDictionary *dic,
                                                 NSError *error))completion;
//注册
+ (NSURLSessionDataTask *)userRegsitUrl:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                  block:(void (^)(NSDictionary *dic,
                                                  NSError *error))completion;

//重置密码
+ (NSURLSessionDataTask *)resetPasswordUrl:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                  block:(void (^)(NSDictionary *dic,
                                                  NSError *error))completion;

//登录
+ (NSURLSessionDataTask *)userLoginUrl:(NSString *)url
                                parameters:(NSDictionary *)parameters
                                     block:(void (^)(NSDictionary *dic,
                                                     NSError *error))completion;
//取消登录
+ (NSURLSessionDataTask *)cancleLoginUrl:(NSString *)url
                            parameters:(NSDictionary *)parameters
                                 block:(void (^)(NSDictionary *dic,
                                                 NSError *error))completion;
//获取用户信息
+ (NSURLSessionDataTask *)getUserInfo:(NSString *)url
                              parameters:(NSDictionary *)parameters
                                   block:(void (^)(NSDictionary *dic,
                                                   NSError *error))completion;


@end
