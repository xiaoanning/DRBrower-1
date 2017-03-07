//
//  DRGeocoder.m
//  DRBrower
//
//  Created by QiQi on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DRGeocoder.h"

@implementation DRGeocoder

- (instancetype)initWithCurrentCity:(NSString *)city subLocality:(NSString *)subLocality{
    if (self = [[DRGeocoder alloc] init]) {
        _city = city;
        _subLocality = subLocality;
    }
    return self;
}

- (void)creatGeocoder:(CLLocation *)location
                block:(void (^)(DRGeocoder *geocoder,
                                NSError *error))completion {
    [self reverseGeocodeLocation:location
                   completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                       if (!error) {
                           if ([placemarks count]>0) {
                               CLPlacemark *placemark = [placemarks firstObject];
                               //city
                               NSString *cityStr = placemark.locality;
                               NSString *subLocalityStr = placemark.subLocality;
                               if (!cityStr) {
                                   cityStr = placemark.administrativeArea;
                               }
                               if (!subLocalityStr)  {
                                   subLocalityStr = @"";
                               }
                               self.city = cityStr;
                               self.subLocality = subLocalityStr;
                               completion(self, error);
                               
                           }else if ([placemarks count] == 0) {
                               [Tools showView:NSLocalizedString(@"定位城市失败", nil)];
                           }
                       }
                       else {
                           [Tools showView:NSLocalizedString(@"请检查你的网络", nil)];
                       }
                   }];
}

@end
