//
//  WebsiteListModel.m
//  DRBrower
//
//  Created by QiQi on 2017/1/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "WebsiteListModel.h"
#import "WebsiteModel.h"

@implementation WebsiteListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}
+ (NSValueTransformer *)listJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[WebsiteModel class]];
}

@end
