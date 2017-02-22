//
//  HistoryVC.h
//  DRBrower
//
//  Created by QiQi on 2017/2/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuVC;

@interface HistoryVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)MenuVC *menuVC;

@end
