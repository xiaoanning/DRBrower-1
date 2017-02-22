//
//  ShareVC.h
//  DRBrower
//
//  Created by QiQi on 2017/2/19.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareModel.h"

@interface ShareVC : UIViewController

@property (strong, nonatomic) ShareModel *shareModel;

- (void)shareSDK:(SSDKPlatformType)shareType;

@end
