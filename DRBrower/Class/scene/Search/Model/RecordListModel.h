//
//  RecordListModel.h
//  DRBrower
//
//  Created by QiQi on 2017/2/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordListModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSArray *data;


@end
