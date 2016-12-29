//
//  NewsTagModel.h
//  DRBrower
//
//  Created by QiQi on 2016/12/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsTagListModel.h"
@interface NewsTagModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSString * tagId;//票编号
@property(nonatomic, strong) NSString * name;//tag name


+ (NSURLSessionDataTask *)getNewsTagUrl:(NSString *)url
                             parameters:(NSDictionary *)parameters
                           block:(void (^)(NewsTagListModel *tagList,
                                           NSError *error))completion;

@end
