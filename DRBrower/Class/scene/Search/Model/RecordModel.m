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
- (void)realmAddRecord {
    NSError *error;
    RLMRealm *realm = [RLMRealm defaultRealm];
    RecordRealm *realmRecord = [RecordRealm recordWithUrl:self.url title:self.title time:self.time];
    RecordRealm *selectRecord = [RecordModel realmSelectRecordWithTitle:self.title url:self.url];
    if (selectRecord) {
        [RecordModel realmDeleteOneRecord:[RecordModel realmChangeToModel:selectRecord]];
    }
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:realmRecord];
    [realm commitWriteTransaction:&error];
}

//删除一条记录
+ (void)realmDeleteOneRecord:(RecordModel *)record {
    NSError *error;
    RLMRealm *realm = [RLMRealm defaultRealm];
    RecordRealm * realmRecord = [RecordModel realmSelectRecordWithTime:record.time];
    // 在事务中删除一个对象
    [realm beginWriteTransaction];
    [realm deleteObject:realmRecord];
    [realm commitWriteTransaction:&error];
}

//清空记录
+ (void)realmDeleteAllRecord {
    NSError *error;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[RecordRealm allObjectsInRealm:realm]];
    [realm commitWriteTransaction:&error];
}

//获取全部记录
+ (NSMutableArray *)realmSelectAllRecord {
    RLMResults<RecordRealm *> *record = [[RecordRealm allObjects] sortedResultsUsingProperty:@"time" ascending:YES];
    NSMutableArray *recodArray = [NSMutableArray arrayWithCapacity:5];
    for (RecordRealm *oneRecord in record) {
        RecordModel *model = [RecordModel realmChangeToModel:oneRecord];
        [recodArray addObject:model];
    }
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);

    return recodArray;
}

+ (RecordRealm *)realmSelectRecordWithTime:(NSInteger)time {
    RLMResults<RecordRealm *> *recordResults = [RecordRealm objectsWithPredicate:
                                                [NSPredicate predicateWithFormat:@"time = %ld", time]];
    RecordRealm *realmRecord = recordResults[0];
    return realmRecord;
    
}

+ (RecordRealm *)realmSelectRecordWithTitle:(NSString *)title url:(NSString *)url {
    RLMResults<RecordRealm *> *recordResults = [RecordRealm objectsWithPredicate:
                                                [NSPredicate predicateWithFormat:@"url = %@ AND title = %@", url,title]];
    if (recordResults.count>0) {
        RecordRealm *realmRecord = recordResults[0];
        return realmRecord;
    }
    return nil;
}



+ (RecordModel *)realmChangeToModel:(RecordRealm *)recordRealm {
    RecordModel *record = [[RecordModel alloc] init];
    record.title = recordRealm.title;
    record.url = recordRealm.url;
    record.time = recordRealm.time;
    return record;
    
}

@end
