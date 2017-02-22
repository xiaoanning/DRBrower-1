//
//  ShareModel.m
//  DRBrower
//
//  Created by QiQi on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "ShareModel.h"

@implementation ShareModel

- (instancetype)initWithShareUrl:(NSString *)url
                           title:(NSString *)title
                            desc:(NSString *)desc
                         content:(NSString *)content
                          image:(UIImage *)image {

    if (self = [[ShareModel alloc] init]) {
        _title = title;
        _shareUrl = url;
        _desc = desc;
        _content = content;
        _image = image;
    }
        return self;
}

+ (instancetype)shareModelWithShareUrl:(NSString *)url
                                 title:(NSString *)title
                                  desc:(NSString *)desc
                               content:(NSString *)content
                                image:(UIImage *)image {
    return [[ShareModel alloc] initWithShareUrl:url
                                          title:title
                                           desc:desc
                                        content:content
                                         image:image];
}



@end
