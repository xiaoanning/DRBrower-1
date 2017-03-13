//
//  KeychainTool.h
//  DRBrower
//
//  Created by apple on 2017/3/13.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface KeychainTool : NSObject

//保存
+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;
//获取
+ (NSString *)getKeychainValue:(NSString *)sKey;
//删除
+ (void)deleteKeychainValue:(NSString *)sKey;

@end
