//
//  UserInfo.m
//  DRBrower
//
//  Created by QiQi on 2017/3/9.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (void)userInfoDefaults:(NSString *)gender {
    [[NSUserDefaults standardUserDefaults] setObject:gender forKey:USERINFO_GENDER];
}

+ (NSString *)getUserGender {
    NSString *gender = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_GENDER];
    return gender;
}

@end
