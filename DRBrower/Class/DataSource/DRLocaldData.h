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

//保存点赞列表
+ (void)saveZanData:(NSMutableArray *)zanArray;
//获取点赞列表
+ (NSMutableArray *)achieveZanData;

//保存举报列表
+ (void)saveComplainData:(NSMutableArray *)complainArray;
//获取举报列表
+ (NSMutableArray *)achieveComplainData;

//保存开关列表
+ (void)saveSwitchData:(NSMutableArray *)switchArray;
//获取开关列表
+ (NSMutableArray *)achieveSwitchData;

//保存选中列表
+ (void)saveSelectedData:(NSMutableArray *)selectedArray;
//获取选中列表
+ (NSMutableArray *)achieveSelectedData;

//保存新闻点击列表
+ (void)saveNewsSelectedData:(NSMutableArray *)selectedArray;
//获取x新闻点击列表
+ (NSMutableArray *)achieveNewsSelectedData;
@end










