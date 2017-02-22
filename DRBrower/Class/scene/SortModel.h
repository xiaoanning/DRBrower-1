//
//  SortModel.h
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SortListModel.h"

@interface SortModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, copy) NSString *comment_num;  //评论人数
@property(nonatomic, copy) NSString *site_type;

@property(nonatomic, copy) NSString *complain_num; //投诉人数
@property(nonatomic, copy) NSString *url;          //网址
@property(nonatomic, copy) NSString *url_md5;      //加密网址
@property(nonatomic, copy) NSString *dev_id;
@property(nonatomic, copy) NSString *love_num;    //点赞人数
@property(nonatomic, copy) NSString *sort_num;
@property(nonatomic, copy) NSString *name;         //标题 ：东京小护士
@property(nonatomic, copy) NSString *location;     //位置：北京市-朝阳
@property(nonatomic, copy) NSString *updatetime;    //更新时间
@property(nonatomic, copy) NSString *visit_num;     //观看人数

+ (NSURLSessionDataTask *)getSortListUrl:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                  block:(void (^)(SortListModel *newsList,
                                                  NSError *error))completion;



@end
