//
//  AdviceModel.h
//  DRBrower
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdviceModel : NSObject
//举报
+ (NSURLSessionDataTask *)addAdviceUrl:(NSString *)url
                              parameters:(NSDictionary *)parameters
                                   block:(void (^)(NSDictionary *dic,
                                                   NSError *error))completion;


@end
