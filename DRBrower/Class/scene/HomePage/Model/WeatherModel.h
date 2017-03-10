//
//  WeatherModel.h
//  DRBrower
//
//  Created by QiQi on 2017/3/3.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (nonatomic, strong)NSString *currentCity;
@property (nonatomic, strong)NSString *pm25;
@property (nonatomic, strong)NSString *temperature;
@property (nonatomic, strong)NSString *weather;
@property (nonatomic, strong)NSString *colorValue;
@property (nonatomic, strong)NSString *airQuality;
@property (nonatomic, strong)NSString *weatherImage;



+ (NSURLSessionDataTask *)getWeatherUrl:(NSString *)url
                             parameters:(NSString *)parameters
                                  block:(void (^)(WeatherModel *weather,
                                                  NSError *error))completion;


@end
