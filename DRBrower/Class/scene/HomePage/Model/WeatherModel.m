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

- (instancetype)initWithCurrentCity:(NSString *)currentCity pm25:(NSString *)pm25 weather:(NSString *)weather temperature:(NSString *)temperature{
    if (self = [[WeatherModel alloc] init]) {
        _currentCity = currentCity;
        _pm25 = pm25;
        _weather = weather;
        _temperature = temperature;
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
                                         NSString *temperature = [tempStr substringToIndex:[tempStr length]-2];

                                         WeatherModel *model = [[WeatherModel alloc] initWithCurrentCity:[resultsDic valueForKey:@"currentCity"]
                                                                                                    pm25:[resultsDic valueForKey:@"pm25"]
                                                                                                 weather:[weather_dataDic valueForKey:@"weather"]
                                                                                             temperature:temperature];
                                         completion(model, error);
                                     }];
}

// TODO:定位


- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}

@end
