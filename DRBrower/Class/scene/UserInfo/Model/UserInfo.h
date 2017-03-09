//
//  UserInfo.h
//  DRBrower
//
//  Created by QiQi on 2017/3/9.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (void)userInfoDefaults:(NSString *)gender;
+ (NSString *)getUserGender;


@end
