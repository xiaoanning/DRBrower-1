//
//  DRLocaldData.h
//  DRBrower
//
//  Created by QiQi on 2017/1/10.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordModel.h"
#import "WebsiteModel.h"

@interface DRLocaldData : NSObject

//website保存
+ (void)saveWebsiteData:(NSMutableArray *)websiteArray;
//获取web
+ (NSMutableArray *)achieveWebsiteData;

//浏览历史 保存
+ (void)saveHistoryData:(NSMutableArray *)historyArray;
//获取浏览历史
+ (NSMutableArray *)achieveHistoryData;
//删除历史
+ (void)deleteOneHistoryData:(RecordModel *)record;
//清空历史
+ (void)deleteAllHistoryData;

//收藏
- (BOOL)saveCollectData:(RecordModel *)record;
//获取收藏
+ (NSMutableArray *)achieveCollectData;
//取消收藏
+ (void)deleteOneCollectData:(RecordModel *)record;
//清空收藏
+ (void)deleteAllCollectData;

@end
