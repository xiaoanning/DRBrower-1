//
//  CommentModel.h
//  DRBrower
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentListModel.h"

@interface CommentModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *createtime;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *comment_id;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *md5;
@property (nonatomic,copy) NSString *dev_id;


+(NSURLSessionDataTask *)getCommentListUrl:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                  block:(void (^)(CommentListModel *commentList,
                                                  NSError *error))completion;

+(NSURLSessionDataTask *)addCommentUrl:(NSString *)url
                                parameters:(NSDictionary *)parameters
                                     block:(void (^)(NSDictionary *dic,
                                                     NSError *error))completion;

@end
