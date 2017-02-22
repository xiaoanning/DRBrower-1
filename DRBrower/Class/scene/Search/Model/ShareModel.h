//
//  ShareModel.h
//  DRBrower
//
//  Created by QiQi on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject


@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;

+ (instancetype)shareModelWithShareUrl:(NSString *)url
                                 title:(NSString *)title
                                  desc:(NSString *)desc
                               content:(NSString *)content
                                image:(UIImage *)image;


@end
