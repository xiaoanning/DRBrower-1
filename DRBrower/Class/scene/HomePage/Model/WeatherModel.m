//
//  WeatherModel.m
//  DRBrower
//
//  Created by QiQi on 2017/3/3.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "WeatherModel.h"
#import "NSString+StringSeparated.h"

@implementation WeatherModel

- (instancetype)initWithCurrentCity:(NSString *)currentCity
                               pm25:(NSString *)pm25
                            weather:(NSString *)weather
                        temperature:(NSString *)temperature
                         colorValue:(NSString *)colorValue
                         airQuality:(NSString *)airQuality
                       weatherImage:(NSString *)weatherImage{
    
    if (self = [[WeatherModel alloc] init]) {
        _currentCity = currentCity;
        _pm25 = pm25;
        _weather = weather;
        _temperature = temperature;
        _colorValue = colorValue;
        _airQuality = airQuality;
        _weatherImage = weatherImage;
    }
    return self;
}

+ (NSURLSessionDataTask *)getWeatherUrl:(NSString *)url
                             parameters:(NSString *)parameters
                                  block:(void (^)(WeatherModel *weather,
                                                  NSError *error))completion {
    if (!parameters) {
        parameters = NSLocalizedString(@"北京", nil);
    }
    NSString *urlStr = [[url stringByAppendingString:parameters]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return [[DRDataService sharedClient] DR_get:urlStr
                                     parameters:nil
                                     completion:^(id response, NSError *error,
                                                  NSDictionary *header) {
                                 NSDictionary *resultsDic = [response[@"results"] firstObject];
                                                                          
                                 NSDictionary *weather_dataDic = [resultsDic[@"weather_data"] firstObject];
                                 NSString *temperatureDataStr = [weather_dataDic valueForKey:@"date"];
                                 
                                 NSString *tempStr = [temperatureDataStr componentsSeparatedByStr:@"："];
                                 NSString *temperature = [[tempStr substringToIndex:[tempStr length]-2] stringByAppendingString:@"°"];
                                         NSString *weather = [weather_dataDic valueForKey:@"weather"];
                                         NSString *pm25 = [resultsDic valueForKey:@"pm25"];
                                         NSDictionary * dic = [WeatherModel getDicByPm25:pm25
                                                                                 weather:weather];
                                
                                 WeatherModel *model = [[WeatherModel alloc] initWithCurrentCity:[resultsDic valueForKey:@"currentCity"]
                                                                                            pm25:pm25
                                                                                         weather:weather
                                                                                     temperature:temperature
                                                                                      colorValue:dic[@"colorValue"]
                                                                                      airQuality:dic[@"airQuality"] weatherImage:dic[@"weatherImage"]];
                                 completion(model, error);
                                     }];
}

+ (NSMutableDictionary *)getDicByPm25:(NSString *)pm25 weather:(NSString *)weather{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    int parseInt = [pm25 intValue];
    if (0 <= parseInt && parseInt < 50) {
        [dic setValuesForKeysWithDictionary:@{@"airQuality":@"空气优",
                                              @"colorValue":@"39e0d6"}];
    } else if (50 <= parseInt && parseInt < 100) {
        [dic setValuesForKeysWithDictionary:@{@"airQuality":@"空气良",
                                              @"colorValue":@"6ce324"}];
    } else if (100 <= parseInt && parseInt < 150) {
        [dic setValuesForKeysWithDictionary:@{@"airQuality":@"轻度污染",
                                              @"colorValue":@"e7cc16"}];
    } else if (150 <= parseInt && parseInt < 200) {
        [dic setValuesForKeysWithDictionary:@{@"airQuality":@"中度污染",
                                              @"colorValue":@"e67c27"}];
    } else if (200 <= parseInt && parseInt < 300) {
        [dic setValuesForKeysWithDictionary:@{@"airQuality":@"重度污染",
                                              @"colorValue":@"c92b41"}];
    } else if (parseInt >= 300) {
        [dic setValuesForKeysWithDictionary:@{@"airQuality":@"严重污染",
                                              @"colorValue":@"8827c5"}];
    }
    
    if ([weather containsString:NSLocalizedString(@"晴", nil)]) {
        [dic setValue:@"weather_fine" forKey:@"weatherImage"];
    }else if ([weather containsString:NSLocalizedString(@"云", nil)]) {
        [dic setValue:@"weather_cloudy" forKey:@"weatherImage"];
    }else if ([weather containsString:NSLocalizedString(@"雨", nil)]) {
        [dic setValue:@"weather_light_rain" forKey:@"weatherImage"];
    }else if ([weather containsString:NSLocalizedString(@"霾", nil)]) {
        [dic setValue:@"weather_haze" forKey:@"weatherImage"];
    }else if ([weather containsString:NSLocalizedString(@"阴", nil)]) {
        [dic setValue:@"weather_overcast" forKey:@"weatherImage"];
    }else if ([weather containsString:NSLocalizedString(@"雪", nil)]) {
        [dic setValue:@"weather_Light_Snow" forKey:@"weatherImage"];
    }else {
        [dic setValue:@"weather_cloudy" forKey:@"weatherImage"];
    }
    
    
    return dic;
}


- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}

@end
