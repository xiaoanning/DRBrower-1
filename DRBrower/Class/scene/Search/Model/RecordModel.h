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

@end
