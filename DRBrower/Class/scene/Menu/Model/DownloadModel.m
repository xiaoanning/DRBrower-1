//
//  DownloadModel.m
//  DRBrower
//
//  Created by QiQi on 2017/2/28.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DownloadModel.h"
#import "DownloadRealm.h"

@implementation DownloadModel

//保存记录
- (void)addDownloadToRealm:(NSString *)realmName {
    NSError *error;
    RLMRealm *realm = [DRRealmPublic createRealmWithName:realmName];
    DownloadRealm *realmDownload = [DownloadRealm downloadWithUrl:self.url title:self.title state:self.state];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:realmDownload];
    [realm commitWriteTransaction:&error];
}

//删除一条记录
+ (void)deleteOneDownload:(DownloadModel *)download fromRealm:(NSString *)realmName {
    NSError *error;
    RLMRealm *realm = [DRRealmPublic createRealmWithName:realmName];
    DownloadRealm * realmDownload = [DownloadModel selectDownloadWithUrl:download.url fromRealm:realmName];
    // 在事务中删除一个对象
    [realm beginWriteTransaction];
    [realm deleteObject:realmDownload];
    [realm commitWriteTransaction:&error];
}

//根据状态删除所有
+ (void)deleteDownloadWithState:(BOOL)state fromRealm:(NSString *)realmName {
    NSError *error;
    RLMRealm *realm = [DRRealmPublic createRealmWithName:realmName];
    [realm beginWriteTransaction];
    [realm deleteObjects:[DownloadModel selectDownloadWithState:state fromRealm:realmName]];
    [realm commitWriteTransaction:&error];
}

//更新下载状态
- (void)updateStateFromRealm:(NSString *)realmName {
    RLMRealm *realm = [DRRealmPublic createRealmWithName:realmName];
    DownloadRealm *downloadRealm = [DownloadRealm downloadWithUrl:self.url
                                                            title:self.title
                                                            state:self.state];
    // 通过 id = 1 更新该书籍
    [realm beginWriteTransaction];
    [DownloadRealm createOrUpdateInRealm:realm withValue:downloadRealm];
    [realm commitWriteTransaction];

}

//按下载状态查询
+ (NSMutableArray *)selectDownloadWithState:(BOOL)state fromRealm:(NSString *)realmName {
    RLMResults<DownloadRealm *> *downloadResults = [DownloadRealm objectsInRealm:[DRRealmPublic createRealmWithName:realmName]
                                                                   withPredicate:[NSPredicate predicateWithFormat:@"state = %ld", state]];
    NSMutableArray *downloadArray = [NSMutableArray arrayWithCapacity:5];
    for (DownloadRealm *oneDownload in downloadResults) {
        DownloadModel *model = [DownloadModel realmChangeToModel:oneDownload];
        [downloadArray addObject:model];
    }
    
    return downloadArray;
    
}

//按url查询
+ (DownloadRealm *)selectDownloadWithUrl:(NSString *)url fromRealm:(NSString *)realmName {
    RLMResults<DownloadRealm *> *downloadResults = [DownloadRealm objectsInRealm:[DRRealmPublic createRealmWithName:realmName]
                                                                   withPredicate:[NSPredicate predicateWithFormat:@"url = %ld", url]];
    DownloadRealm *realmDownload = downloadResults[0];
    return realmDownload;
    
}

//realm data转化model
+ (DownloadModel *)realmChangeToModel:(DownloadRealm *)downloadRealm {
    DownloadModel *download = [[DownloadModel alloc] init];
    download.title = downloadRealm.title;
    download.url = downloadRealm.url;
    download.state = downloadRealm.state;
    return download;
    
}

@end
