//
//  DRHomeVC.h
//  DRBrower
//
//  Created by QiQi on 2016/12/20.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTopView.h"
#import "TagsView.h"
#import "HomeToolBar.h"

#import "PYSearch.h"

@interface DRHomeVC : UIViewController<UITableViewDelegate,UITableViewDataSource,HomeToolBarDelegate,PYSearchViewControllerDelegate,HomeTopViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;


@end
