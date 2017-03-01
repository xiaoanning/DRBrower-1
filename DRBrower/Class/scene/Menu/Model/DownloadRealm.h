//
//  DownloadRealm.h
//  DRBrower
//
//  Created by QiQi on 2017/3/1.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadRealm : RLMObject

@property (strong, nonatomic)NSString *url;
@property (strong, nonatomic)NSString *title;
@property (assign, nonatomic)BOOL state;

+ (instancetype)downloadWithUrl:(NSString *)url title:(NSString *)title state:(BOOL)state;

@end
