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

//保存记录
- (void)realmAddRecord;
//删除一条记录
+ (void)realmDeleteOneRecord:(RecordModel *)record;
//清空记录
+ (void)realmDeleteAllRecord;
//获取全部记录
+ (NSMutableArray *)realmSelectAllRecord;

@end
