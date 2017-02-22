//
//  Tools.m
//  DRBrower
//
//  Created by QiQi on 2017/1/4.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "Tools.h"

#define REGULATOR_TYPE_URL @0
#define REGULATOR_TYPE_IP @1

@implementation Tools

#pragma mark - 正则表达式判断网址合法
+ (NSString *)urlValidation:(NSString *)string {
    
    if ([[string lowercaseString] hasPrefix:@"http://"] || [[string lowercaseString] hasPrefix:@"https://"] ) {
        return string;
    }
    
    if ([[string lowercaseString] hasPrefix:@"www."]) {
        return [NSString stringWithFormat:@"http://%@",string];
    }
    
    if ([string hasSuffix:@".com"] || [string hasSuffix:@".cn"] || [string hasSuffix:@".net"] || [string hasSuffix:@"org"] || [string hasSuffix:@"biz"] || [string hasSuffix:@"info"] || [string hasSuffix:@"cc"] || [string hasSuffix:@"tv"]) {
        return [NSString stringWithFormat:@"http://%@",string];
    }
    
    NSString *strUrl = [Tools regulatorUrl:string type:REGULATOR_TYPE_URL];
    if (![strUrl isEqualToString:@""]) {
        return [NSString stringWithFormat:@"http://%@",strUrl];
    }

    NSString *strIP = [Tools regulatorUrl:string type:REGULATOR_TYPE_IP];
    if (![strIP isEqualToString:@""]) {
        return [NSString stringWithFormat:@"http://%@",strIP];
    }

    else {
        return [NSString stringWithFormat:@"%@%@",URL_BAIDU_SEARCH,string];
    }
}

+ (NSString *)regulatorUrl:(NSString *)str type:(NSNumber *)type{
    NSError *error;
    
    NSString *regulaStr;
    if ([type isEqual:REGULATOR_TYPE_URL]) {
        regulaStr = @"(https?://(w{3}\\.)?)?\\w+\\.\\w+(\\.[a-zA-Z]+)*(:\\d{1,5})?(/\\w*)*(\\??(.+=.*)?(&.+=.*)?)?";
        
    }else {
        regulaStr = @"[1-9](\\d{1,2})?\\.(0|([1-9](\\d{1,2})?))\\.(0|([1-9](\\d{1,2})?))\\.(0|([1-9](\\d{1,2})?))";
        
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:str options:0
                                                  range:NSMakeRange(0, [str length])];
    
    NSString *string = @"";// = [arrayOfAllMatches componentsJoinedByString:@""];
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        NSString* substringForMatch = [str substringWithRange:match.range];
        NSLog(@"substringForMatch = %@",substringForMatch);
        string = [string stringByAppendingString:substringForMatch];
    }
    
    return string;
}

#pragma mark - 判断数组元素个数 决定pageControl的高度个页数
+ (BOOL)isRemainder:(NSArray *)array {
    if ([array count] <= 10) {
        return NO;
    }
    if([array count]%10 > 0 || [array count]%10 == 0) {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - 当前时间戳
+ (NSInteger)atPresentTimestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSInteger timeSp = (long)[datenow timeIntervalSince1970];
    
    return timeSp;
}


@end
