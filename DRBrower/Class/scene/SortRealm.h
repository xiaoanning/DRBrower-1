//
//  SortRealm.h
//  DRBrower
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortRealm : RLMObject
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
@property(nonatomic, assign) NSString *sort_id;     //唯一id

+ (instancetype)sortWithComment_num:(NSString *)comment_num
                          site_type:(NSString *)site_type
                       complain_num:(NSString *)complain_num
                                url:(NSString *)url
                            url_md5:(NSString *)url_md5
                             dev_id:(NSString *)dev_id
                           love_num:(NSString *)love_num
                           sort_num:(NSString *)sort_num
                               name:(NSString *)name
                           location:(NSString *)location
                         updatetime:(NSString *)updatetime
                          visit_num:(NSString *)visit_num
                            sort_id:(NSString *)sort_id;

@end
