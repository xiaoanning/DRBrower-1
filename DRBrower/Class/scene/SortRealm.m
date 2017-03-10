//
//  SortRealm.m
//  DRBrower
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "SortRealm.h"

@implementation SortRealm

+ (NSString *)primaryKey {
    return @"sort_id";
}

+ (NSArray *)requiredProperties {
    return @[@"comment_num",@"site_type",@"complain_num",@"url",@"url_md5",@"dev_id",@"love_num",@"sort_num",@"name",@"location",@"updatetime",@"visit_num"];
}

- (instancetype)initWithComment_num:(NSString *)comment_num site_type:(NSString *)site_type complain_num:(NSString *)complain_num url:(NSString *)url url_md5:(NSString *)url_md5 dev_id:(NSString *)dev_id love_num:(NSString *)love_num sort_num:(NSString *)sort_num name:(NSString *)name location:(NSString *)location updatetime:(NSString *)updatetime visit_num:(NSString *)visit_num sort_id:(NSString *)sort_id {
    if (self = [[SortRealm alloc] init]) {
        _comment_num = comment_num;
        _site_type = site_type;
        _complain_num = complain_num;
        _url = url;
        _url_md5 = url_md5;
        _dev_id = dev_id;
        _love_num = love_num;
        _sort_num = sort_num;
        _name = name;
        _location = location;
        _updatetime = updatetime;
        _visit_num = visit_num;
        _sort_id = sort_id;
    }
    return self;
}

+(instancetype)sortWithComment_num:(NSString *)comment_num site_type:(NSString *)site_type complain_num:(NSString *)complain_num url:(NSString *)url url_md5:(NSString *)url_md5 dev_id:(NSString *)dev_id love_num:(NSString *)love_num sort_num:(NSString *)sort_num name:(NSString *)name location:(NSString *)location updatetime:(NSString *)updatetime visit_num:(NSString *)visit_num sort_id:(NSString *)sort_id {
    return [[SortRealm alloc] initWithComment_num:comment_num site_type:site_type complain_num:complain_num url:url url_md5:url_md5 dev_id:dev_id love_num:love_num sort_num:sort_num name:name location:location updatetime:updatetime visit_num:visit_num sort_id:sort_id];
}


@end
