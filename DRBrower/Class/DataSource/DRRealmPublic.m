//
//  DRRealmPublic.m
//  DRBrower
//
//  Created by QiQi on 2017/2/24.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DRRealmPublic.h"

@implementation DRRealmPublic

//创建realm
+ (RLMRealm *)createRealmWithName:(NSString *)realmName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathStr = paths.firstObject;
    RLMRealm *realm = [RLMRealm realmWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.realm",pathStr,realmName]]];
    return realm;
}


@end
