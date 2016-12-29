//
//  NewsTagListModel.m
//  DRBrower
//
//  Created by QiQi on 2016/12/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "NewsTagListModel.h"
#import "NewsTagModel.h"

@implementation NewsTagListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+ (NSValueTransformer *)dataJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NewsTagModel class]];
}

@end
