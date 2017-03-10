//
//  SortModel.m
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "SortModel.h"
#import "SortRealm.h"

@implementation SortModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sort_id" : @"id"
             };
}

+(NSURLSessionDataTask *)getSortListUrl:(NSString *)url
                              parameters:(NSDictionary *)parameters
                                   block:(void (^)(SortListModel *newsList,
                                                   NSError *error))completion{
    return [[DRDataService sharedClient] DR_get:url parameters:@{} completion:^(id response, NSError *error, NSDictionary *header) {
        SortListModel *sortList = [MTLJSONAdapter modelOfClass:[SortListModel class]
                                            fromJSONDictionary:response
                                                         error:&error];
        completion(sortList,error);
    }];
}

+(NSURLSessionDataTask *)addLoveUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}
+(NSURLSessionDataTask *)addComplainUrl:(NSString *)url parameters:(NSDictionary *)parameters block:(void (^)(NSDictionary *, NSError *))completion {
    return [[DRDataService sharedClient] DR_get:url parameters:parameters completion:^(id response, NSError *error, NSDictionary *header) {
        completion(response,error);
    }];
}


//保存记录
-(void)addSortToRealm:(NSString *)realmName {
    NSError *error;
    RLMRealm *realm = [DRRealmPublic createRealmWithName:realmName];
    SortRealm *realmSort = [SortRealm sortWithComment_num:self.comment_num site_type:self.site_type complain_num:self.complain_num url:self.url url_md5:self.url_md5 dev_id:self.dev_id love_num:self.love_num sort_num:self.sort_num name:self.name location:self.location updatetime:self.updatetime visit_num:self.visit_num sort_id:self.sort_id];
    
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:realmSort];
    [realm commitWriteTransaction:&error];
}
//清空记录
+ (void)deleteAllSortFromRealm:(NSString *)realmName {
    NSError *error;
    RLMRealm *realm = [DRRealmPublic createRealmWithName:realmName];
    [realm beginWriteTransaction];
    [realm deleteObjects:[SortRealm allObjectsInRealm:realm]];
    [realm commitWriteTransaction:&error];
}

//获取全部记录
+ (NSMutableArray *)realmSelectAllSortFromRealm:(NSString *)realmName {
    
    RLMResults<SortRealm *> *sort = [SortRealm allObjectsInRealm:[DRRealmPublic createRealmWithName:realmName]];
    NSMutableArray *sortArray = [NSMutableArray arrayWithCapacity:5];
    for (SortRealm *oneSort in sort) {
        SortModel *model = [SortModel realmChangeToModel:oneSort];
        [sortArray addObject:model];
    }
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    
    return sortArray;
}

//realm data转化model
+ (SortModel *)realmChangeToModel:(SortRealm *)SortRealm {
    SortModel *sort = [[SortModel alloc] init];
    sort.comment_num = SortRealm.comment_num;
    sort.site_type = SortRealm.site_type;
    sort.complain_num = SortRealm.complain_num;
    sort.url = SortRealm.url;
    sort.dev_id = SortRealm.dev_id;
    sort.url_md5 = SortRealm.url_md5;
    sort.love_num = SortRealm.love_num;
    sort.sort_num = SortRealm.sort_num;
    sort.name = SortRealm.name;
    sort.location = SortRealm.location;
    sort.updatetime = SortRealm.updatetime;
    sort.visit_num = SortRealm.visit_num;
    sort.sort_id = SortRealm.sort_id;
    return sort;
}
@end
