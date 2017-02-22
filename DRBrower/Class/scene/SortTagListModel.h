//
//  SortTagListModel.h
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortTagListModel : MTLModel<MTLJSONSerializing>

@property(strong, nonatomic) NSArray *data;

@end
