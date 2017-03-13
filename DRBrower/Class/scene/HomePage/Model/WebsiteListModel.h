//
//  WebsiteListModel.h
//  DRBrower
//
//  Created by QiQi on 2017/1/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebsiteListModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSMutableArray *list;

@end
