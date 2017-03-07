//
//  DRGeocoder.h
//  DRBrower
//
//  Created by QiQi on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface DRGeocoder : CLGeocoder

@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *subLocality;

- (void)creatGeocoder:(CLLocation *)location
                block:(void (^)(DRGeocoder *geocoder,
                                NSError *error))completion;

@end
