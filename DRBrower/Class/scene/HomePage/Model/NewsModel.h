//
//  NewsModel.h
//  DRBrower
//
//  Created by QiQi on 2016/12/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsListModel.h"
@interface NewsModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSString *title;//新闻标题
@property(nonatomic, strong) NSString *url;//地址
@property(nonatomic, strong) NSMutableArray *imgs;//图片
@property (nonatomic,assign) BOOL isSelected;
+ (NSURLSessionDataTask *)getNewsByTagUrl:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                  block:(void (^)(NewsListModel *newsList,
                                                  NSError *error))completion;

@end
