//
//  HotWordModel.h
//  DRBrower
//
//  Created by QiQi on 2017/3/12.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotWordModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong)NSArray *list;

+ (NSURLSessionDataTask *)getHotWordUrl:(NSString *)url
                               parameters:(NSDictionary *)parameters
                                    block:(void (^)(HotWordModel *newsList,
                                                    NSError *error))completion;

@end
