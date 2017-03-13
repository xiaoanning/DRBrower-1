//
//  Tools.h
//  DRBrower
//
//  Created by QiQi on 2017/1/4.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

#pragma mark - 正则表达式判断网址合法
+ (NSString *)urlValidation:(NSString *)string;
#pragma mark - 正则表达式判断手机号合法性
+ (BOOL)phoneNumberValidation:(NSString *)phoneNum;
#pragma mark - pageControl页数
+ (NSInteger)pageCount:(NSArray *)array;
#pragma mark - head高度
+ (NSInteger)headHeight:(NSArray *)array;
#pragma 将时间戳转换为北京时间
+(NSString *)getDateString:(NSString *)spString;
#pragma mark - 当前时间戳
+ (NSInteger)atPresentTimestamp;
#pragma mark - md5加密
+ (NSString *) md5:(NSString *)input;
#pragma mark - url中文编码
+ (NSString *)urlEncodedString:(NSString *)urlStr;
#pragma mark - 申请加入QQ群
+ (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key;

#pragma mark - 提示窗
+ (void)showView:(NSString *)title;
@end
