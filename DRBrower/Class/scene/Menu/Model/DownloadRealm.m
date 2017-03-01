//
//  DownloadRealm.m
//  DRBrower
//
//  Created by QiQi on 2017/3/1.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DownloadRealm.h"

@implementation DownloadRealm


+ (NSString *)primaryKey {
    return @"url";
}

+ (NSArray *)requiredProperties {
    return @[@"title",@"url",@"state"];
}

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title state:(BOOL)state {
    if (self = [[DownloadRealm alloc] init]) {
        _title = title;
        _url = url;
        _state = state;
    }
    return self;
}

+ (instancetype)downloadWithUrl:(NSString *)url title:(NSString *)title state:(BOOL)state {
    return [[DownloadRealm alloc] initWithUrl:url title:title state:state];
}


@end
