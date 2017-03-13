//
//  Tools.m
//  DRBrower
//
//  Created by QiQi on 2017/1/4.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "Tools.h"
#import <CommonCrypto/CommonCrypto.h>

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
#pragma mark - 正则表达式判断手机号合法性
+ (BOOL)phoneNumberValidation:(NSString *)phoneNum
{
    if (phoneNum.length != 11) {
        return NO;
    }
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    
    // 一个判断是否是手机号码的正则表达式
    NSString *pattern = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",CM_NUM,CU_NUM,CT_NUM];
    
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *mobile = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        NO;
    }
    
    // 无符号整型数据接收匹配的数据的数目
    NSUInteger numbersOfMatch = [regularExpression numberOfMatchesInString:mobile options:NSMatchingReportProgress range:NSMakeRange(0, mobile.length)];
    if (numbersOfMatch>0) return YES;
    
    return NO;
    
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
+ (NSInteger)pageCount:(NSArray *)array {
    NSInteger pageCount;
    if ([array count] > 15) {
        if ([array count]%15 > 0) {
            pageCount = [array count]/15 + 1;
        }else {
            pageCount = [array count]/15;
        }
        return pageCount;
    }else {
        return 0;
    }

}

+ (NSInteger)headHeight:(NSArray *)array {
    if ([array count] <= 10) {
        return 320 - 25;
    }else if ([array count] >10 && [array count] <= 15) {
        return 320 - 25 + 80;
    }else if ([array count] > 15) {
        return 320 + 80;
    }
    return 155;
}

+(NSString *)getDateString:(NSString *)spString
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* string=[dateFormat stringFromDate:confromTimesp];
    return string;
}
#pragma mark - 当前时间戳
+ (NSInteger)atPresentTimestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSInteger timeSp = (long)[datenow timeIntervalSince1970];
    
    return timeSp;
}

+ (NSString *) md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
+ (NSString *)urlEncodedString:(NSString *)urlStr {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              
                                                              (CFStringRef)urlStr,
                                                              
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              
                                                              NULL,
                                                              
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
//申请加入QQ群 http://qun.qq.com/join.html
+ (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key{
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", key,@"ec0b0babccfd35290d551f1571dac5f256f4a114c5878b55eafce5dff738973f"];
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    else return NO;
}
//提示窗
+ (void)showView:(NSString *)title{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(title, @"HUD message title");
    hud.tintColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:1.f];
    
}

@end
