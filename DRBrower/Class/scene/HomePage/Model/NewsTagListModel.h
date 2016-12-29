//
//  NewsTagListModel.h
//  DRBrower
//
//  Created by QiQi on 2016/12/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsTagListModel : MTLModel<MTLJSONSerializing>

@property(strong, nonatomic) NSArray *data;


@end
