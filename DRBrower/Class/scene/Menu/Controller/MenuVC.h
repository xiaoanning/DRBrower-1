//
//  MenuVC.h
//  DRBrower
//
//  Created by QiQi on 2017/1/17.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuVCDelegate <NSObject>
@optional
- (void)touchUpCollectButtonAction;

@end

@interface MenuVC : UIViewController

@property (nonatomic, strong)NSString *str;
@property (nonatomic, assign)id<MenuVCDelegate>delegate;

@end