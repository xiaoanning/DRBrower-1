//
//  RecordRealm.h
//  DRBrower
//
//  Created by QiQi on 2017/2/16.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordRealm : RLMObject

@property (strong, nonatomic)NSString *url;
@property (strong, nonatomic)NSString *title;
@property (assign, nonatomic)NSInteger time;
@property (strong, nonatomic)NSString *icon;

+ (instancetype)recordWithUrl:(NSString *)url
                        title:(NSString *)title
                         time:(NSInteger)time
                         icon:(NSString *)icon;


@end
