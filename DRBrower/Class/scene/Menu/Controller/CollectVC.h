//
//  CollectVC.h
//  DRBrower
//
//  Created by QiQi on 2017/2/8.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecordRootVC;

@interface CollectVC : UIViewController<UITableViewDelegate, UITableViewDataSource,AXStretchableSubViewControllerViewSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) RecordRootVC *recordRootVC;

@end
