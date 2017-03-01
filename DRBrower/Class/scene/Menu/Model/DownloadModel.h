//
//  DownloadModel.h
//  DRBrower
//
//  Created by QiQi on 2017/2/28.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadModel : NSObject

@property (strong, nonatomic)NSString *url;
@property (strong, nonatomic)NSString *title;
@property (assign, nonatomic)BOOL state;

//保存记录
- (void)addDownloadToRealm:(NSString *)realmName;
//删除一条记录
+ (void)deleteOneDownload:(DownloadModel *)download fromRealm:(NSString *)realmName;
//根据状态删除所有
+ (void)deleteDownloadWithState:(BOOL)state fromRealm:(NSString *)realmName;
//更新下载状态
- (void)updateStateFromRealm:(NSString *)realmName;
//按下载状态查询
+ (NSMutableArray *)selectDownloadWithState:(BOOL)state fromRealm:(NSString *)realmName;



//+ (void)downloadFile:(NSString *)url
//               block:(void (^)(id response,
//                               NSError *error))completion;

@end
