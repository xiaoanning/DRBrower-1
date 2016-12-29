//
//  NewsListModel.h
//  DRBrower
//
//  Created by QiQi on 2016/12/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSArray *data;



@end
