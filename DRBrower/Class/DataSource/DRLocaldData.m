//
//  DRLocaldData.m
//  DRBrower
//
//  Created by QiQi on 2017/1/10.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DRLocaldData.h"

#define WEBSITE @"ownerWebsite"
#define COLLECT @"collectData"
#define HISTORY @"historyRecords"

@implementation DRLocaldData

//返回的路径
+ (NSString *)savePathName:(NSString *)name {
    //获取沙盒路径
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
    NSString *pathStr = [pathArray objectAtIndex:0];
    //拼接路径和名字得到文件路径
    NSString *filePath = [pathStr stringByAppendingPathComponent:name];
    return filePath;
}

//保存文件
+ (void)rootSaveData:(NSMutableArray *)array fileName:(NSString *)fileName {
    NSString *filePath = [self savePathName:fileName];//获取文件路径
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];//原数据转化为NSData类型
    NSMutableArray *listArray =
    [[NSMutableArray alloc] initWithObjects:data, nil];//把data放在数组
    [listArray writeToFile:filePath atomically:YES];//把数组写入文件
}

//保存网址
+ (void)saveWebsiteData:(NSMutableArray *)websiteArray {
    [DRLocaldData rootSaveData:websiteArray fileName:WEBSITE];

}

//获取网址列表
+ (NSMutableArray *)achieveWebsiteData {
    NSString *filePath = [self savePathName:WEBSITE];//获取文件路径
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];//把文件取出放入数字
    NSMutableArray *websiteArray =
    [NSKeyedUnarchiver unarchiveObjectWithData:dataArray[0]];//把数组中的data转化为
    return websiteArray;

}

//删除网址
+ (void)deleteOneWebsiteData:(WebsiteModel *)website {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self achieveWebsiteData]];
    if ([array containsObject:website]) {
        [array removeObject:website];
    }
    [DRLocaldData rootSaveData:array fileName:WEBSITE];
    
}

//浏览历史 保存
+ (void)saveHistoryData:(NSMutableArray *)historyArray {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self achieveHistoryData]];
    [array addObjectsFromArray:historyArray];
    array = [array valueForKeyPath:@"@distinctUnionOfObjects.self"];
//    [array insertObjects:historyArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, historyArray.count)]];
    
    [DRLocaldData rootSaveData:array fileName:HISTORY];
}

//获取浏览历史
+ (NSMutableArray *)achieveHistoryData {
    NSString *filePath = [self savePathName:HISTORY];//获取文件路径
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];//把文件取出放入数字
    NSMutableArray *historyArray =
    [NSKeyedUnarchiver unarchiveObjectWithData:dataArray[0]];//把数组中的data转化为
    return historyArray;
}

//删除历史
+ (void)deleteOneHistoryData:(RecordModel *)record {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self achieveHistoryData]];
    if ([array containsObject:record]) {
        [array removeObject:record];
    }
    [DRLocaldData rootSaveData:array fileName:HISTORY];
    
}

//清空历史
+ (void)deleteAllHistoryData {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self achieveHistoryData]];
    [array removeAllObjects];
    [DRLocaldData rootSaveData:array fileName:HISTORY];
    
}

//收藏 参数用model
- (BOOL)saveCollectData:(RecordModel *)record {
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:[DRLocaldData achieveCollectData]];
    if (![dataArray containsObject:record]) {
        [dataArray insertObject:record atIndex:0];
        [DRLocaldData rootSaveData:dataArray fileName:COLLECT];
        return YES;
    }
    return NO;
}

//收藏获取
+ (NSMutableArray *)achieveCollectData {
    
    NSString *filePath = [self savePathName:COLLECT];//获取文件路径
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];//把文件取出放入数字
    NSMutableArray *collectArray =
    [NSKeyedUnarchiver unarchiveObjectWithData:dataArray[0]];//把数组中的data转化为
    return collectArray;
    
}

//取消收藏
+ (void)deleteOneCollectData:(RecordModel *)record {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self achieveCollectData]];
    if ([array containsObject:record]) {
        [array removeObject:record];
    }
    [DRLocaldData rootSaveData:array fileName:COLLECT];
    
}


@end
