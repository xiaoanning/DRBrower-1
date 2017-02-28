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
- (void)touchUpFullScreenButtonAction:(BOOL)isfull;
- (void)touchUpRefreshDataButtonAction;

@end

@interface MenuVC : UIViewController

@property (nonatomic, assign)id<MenuVCDelegate>delegate;

@end
