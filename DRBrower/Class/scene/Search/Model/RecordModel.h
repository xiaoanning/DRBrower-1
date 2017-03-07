//
//  RecordModel.h
//  DRBrower
//
//  Created by QiQi on 2017/2/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordListModel.h"

@interface RecordModel : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic)NSString *url;
@property (strong, nonatomic)NSString *title;
@property (assign, nonatomic)NSInteger time;
@property (strong, nonatomic)NSString *icon;

//保存记录
- (void)addRecordToRealm:(NSString *)realmName;
//删除一条记录
+ (void)deleteOneRecord:(RecordModel *)record fromRealm:(NSString *)realmName;
//清空记录
+ (void)deleteAllRecordFromRealm:(NSString *)realmName;
//获取全部记录
+ (NSMutableArray *)realmSelectAllRecordFromRealm:(NSString *)realmName;


@end
