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
#pragma mark - 判断数组元素个数 决定pageControl的高度个页数
+ (BOOL)isRemainder:(NSArray *)array;
#pragma mark - 当前时间戳
+ (NSInteger)atPresentTimestamp;

@end
