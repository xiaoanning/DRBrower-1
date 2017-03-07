//
//  NSString+StringSeparated.m
//  DRBrower
//
//  Created by QiQi on 2017/3/5.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "NSString+StringSeparated.h"

@implementation NSString (StringSeparated)


-(NSString *)componentsSeparatedByStr:(NSString *)components{

    if ([self containsString:components]) {
        
        NSArray * temperatureArray = [self componentsSeparatedByString:components];
        
        return [temperatureArray lastObject];
    }else{
        return @"";  
    }
    
 
}


@end
