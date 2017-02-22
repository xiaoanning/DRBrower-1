//
//  DRLocaldData.h
//  DRBrower
//
//  Created by QiQi on 2017/1/10.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRLocaldData : NSObject

//website保存
+ (void)saveWebsiteData:(NSMutableArray *)websiteArray;
//获取web
+ (NSMutableArray *)achieveWebsiteData;

@end
