//
//  SortModel.h
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SortTagListModel.h"

@interface SortTagModel : MTLModel<MTLJSONSerializing>
@property(nonatomic, strong) NSString *site_type;//类型
@property(nonatomic, strong) NSString *name;//视频，最新电影，其他

+ (NSURLSessionDataTask *)getSortTagUrl:(NSString *)url
                               parameters:(NSDictionary *)parameters
                                    block:(void (^)(SortTagListModel *newsList,
                                                    NSError *error))completion;


@end
