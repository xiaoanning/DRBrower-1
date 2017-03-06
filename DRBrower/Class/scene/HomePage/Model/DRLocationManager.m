//
//  DRLocationManager.m
//  DRBrower
//
//  Created by QiQi on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DRLocationManager.h"

@implementation DRLocationManager

- (void)creatManager {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            // 以下方法选择其中一个
            // 请求始终授权   无论app在前台或者后台都会定位
            //  [locationManager requestAlwaysAuthorization];
            // 当app使用期间授权    只有app在前台时候才可以授权
            [self requestWhenInUseAuthorization];
        }
        // 距离筛选器   单位:米   100米:用户移动了100米后会调用对应的代理方法didUpdateLocations
        // kCLDistanceFilterNone  使用这个值得话只要用户位置改动就会调用定位
        self.distanceFilter = 1000.0;
        // 期望精度  单位:米   100米:表示将100米范围内看做一个位置 导航使用kCLLocationAccuracyBestForNavigation
        self.desiredAccuracy = kCLLocationAccuracyBestForNavigation;

        // 4.开始定位 (更新位置)
        [self startUpdatingLocation];
        
        // 5.临时开启后台定位  iOS9新增方法  必须要配置info.plist文件 不然直接崩溃
        self.allowsBackgroundLocationUpdates = YES;
    
}
@end
