//
//  DRLocaldData.m
//  DRBrower
//
//  Created by QiQi on 2017/1/10.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DRLocaldData.h"

#define WEBSITE @"ownerWebsite"

@implementation DRLocaldData

+ (void)saveWebsiteData:(NSMutableArray *)websiteArray {
    NSString *filePath = [self savePathName:WEBSITE];//获取文件路径
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:websiteArray];//原数据转化为NSData类型
    NSMutableArray *listArray =
    [[NSMutableArray alloc] initWithObjects:data, nil];//把data放在数组
    [listArray writeToFile:filePath atomically:YES];//把数组写入文件

}

+ (NSMutableArray *)achieveWebsiteData {
    NSString *filePath = [self savePathName:WEBSITE];//获取文件路径
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];//把文件取出放入数字
    NSMutableArray *websiteArray =
    [NSKeyedUnarchiver unarchiveObjectWithData:dataArray[0]];//把数组中的data转化为
    return websiteArray;

}

//TODO:收藏 参数用model 每次收藏一个
+ (void)saveCollectData:(NSMutableArray *)websiteArray {
    NSString *filePath = [self savePathName:WEBSITE];//获取文件路径
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:websiteArray];//原数据转化为NSData类型
    NSMutableArray *listArray =
    [[NSMutableArray alloc] initWithObjects:data, nil];//把data放在数组
    [listArray writeToFile:filePath atomically:YES];//把数组写入文件
    
}

+ (NSMutableArray *)achieveCollectData {
    NSString *filePath = [self savePathName:WEBSITE];//获取文件路径
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];//把文件取出放入数字
    NSMutableArray *websiteArray =
    [NSKeyedUnarchiver unarchiveObjectWithData:dataArray[0]];//把数组中的data转化为
    return websiteArray;
    
}

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

@end
