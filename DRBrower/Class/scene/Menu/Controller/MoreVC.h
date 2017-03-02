//
//  MoreVC.h
//  DRBrower
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuVC.h"

@interface MoreVC : UIViewController<UITableViewDelegate,UITableViewDataSource,MenuVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *moreTableView;

@end
