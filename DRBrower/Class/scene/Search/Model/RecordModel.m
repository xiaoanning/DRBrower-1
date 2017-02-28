//
//  RecordModel.m
//  DRBrower
//
//  Created by QiQi on 2017/2/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "RecordModel.h"
#import "RecordRealm.h"

@implementation RecordModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

//保存记录
- (void)addRecordToRealm:(NSString *)realmName {
    NSError *error;
    RLMRealm *realm = [DRRealmPublic createRealmWithName:realmName];
    RecordRealm *realmRecord = [RecordRealm recordWithUrl:self.url title:self.title time:self.time];
    RecordRealm *selectRecord = [RecordModel realmSelectRecordWithTitle:self.title url:self.url fromRealm:realmName];
    if (selectRecord) {
        [RecordModel deleteOneRecord:[RecordModel realmChangeToModel:selectRecord] fromRealm:realmName];
    }
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:realmRecord];
    [realm commitWriteTransaction:&error];
    [RecordModel selectResultsNumberFromRealm:realmName];
}

//删除一条记录
+ (void)deleteOneRecord:(RecordModel *)record fromRealm:(NSString *)realmName{
    NSError *error;
    RLMRealm *realm = [DRRealmPublic createRealmWithName:realmName];
    RecordRealm * realmRecord = [RecordModel realmSelectRecordWithTime:record.time fromRealm:realmName];
    // 在事务中删除一个对象
    [realm beginWriteTransaction];
    [realm deleteObject:realmRecord];
    [realm commitWriteTransaction:&error];
}

//清空记录
+ (void)deleteAllRecordFromRealm:(NSString *)realmName {
    NSError *error;
    RLMRealm *realm = [DRRealmPublic createRealmWithName:realmName];
    [realm beginWriteTransaction];
    [realm deleteObjects:[RecordRealm allObjectsInRealm:realm]];
    [realm commitWriteTransaction:&error];
}

//获取全部记录
+ (NSMutableArray *)realmSelectAllRecordFromRealm:(NSString *)realmName {

    RLMResults<RecordRealm *> *record = [RecordModel selectAllResultsFromRealm:realmName];
    NSMutableArray *recodArray = [NSMutableArray arrayWithCapacity:5];
    for (RecordRealm *oneRecord in record) {
        RecordModel *model = [RecordModel realmChangeToModel:oneRecord];
        [recodArray addObject:model];
    }
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);

    return recodArray;
}

//查询所有并按时间排序 结果
+ (RLMResults *)selectAllResultsFromRealm:(NSString *)realmName {
        RLMResults<RecordRealm *> *record = [[RecordRealm allObjectsInRealm:[DRRealmPublic createRealmWithName:realmName]] sortedResultsUsingProperty:@"time" ascending:NO];
    NSLog(@"历史记录 条数 %lu",(unsigned long)record.count);
    return record;
}

//判断条数
+ (void)selectResultsNumberFromRealm:(NSString *)realmName {
    RLMResults<RecordRealm *> *record = [self selectAllResultsFromRealm:realmName];
    if ([record count] >500) {
        RecordRealm * rR = [record lastObject];
        [RecordModel deleteOneRecord:[RecordModel realmChangeToModel:rR] fromRealm:realmName];
    }
    
}

//按时间查询
+ (RecordRealm *)realmSelectRecordWithTime:(NSInteger)time fromRealm:(NSString *)realmName {
    RLMResults<RecordRealm *> *recordResults = [RecordRealm objectsInRealm:[DRRealmPublic createRealmWithName:realmName]
                                                             withPredicate:[NSPredicate predicateWithFormat:@"time = %ld", time]];
    RecordRealm *realmRecord = recordResults[0];
    return realmRecord;
    
}

//按title和url查询
+ (RecordRealm *)realmSelectRecordWithTitle:(NSString *)title url:(NSString *)url fromRealm:(NSString *)realmName {
    RLMResults<RecordRealm *> *recordResults = [RecordRealm objectsInRealm:[DRRealmPublic createRealmWithName:realmName]
                                                             withPredicate:[NSPredicate predicateWithFormat:@"url = %@ AND title = %@", url,title]];
    if (recordResults.count>0) {
        RecordRealm *realmRecord = recordResults[0];
        return realmRecord;
    }
    return nil;
}

//realm data转化model
+ (RecordModel *)realmChangeToModel:(RecordRealm *)recordRealm {
    RecordModel *record = [[RecordModel alloc] init];
    record.title = recordRealm.title;
    record.url = recordRealm.url;
    record.time = recordRealm.time;
    return record;
    
}

@end
