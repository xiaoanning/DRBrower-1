//
//  RecordRealm.m
//  DRBrower
//
//  Created by QiQi on 2017/2/16.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "RecordRealm.h"

@implementation RecordRealm

+ (NSString *)primaryKey {
    return @"time";
}

+ (NSArray *)requiredProperties {
    return @[@"title",@"url",@"time"];
}

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title time:(NSInteger)time icon:(NSString *)icon {
    if (self = [[RecordRealm alloc] init]) {
        _title = title;
        _url = url;
        _time = time;
    }
    return self;
}

+ (instancetype)recordWithUrl:(NSString *)url title:(NSString *)title time:(NSInteger)time icon:(NSString *)icon {
    return [[RecordRealm alloc] initWithUrl:url title:title time:time icon:icon];
}


@end
