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

@interface DRHomeVC : UIViewController<UITableViewDelegate,UITableViewDataSource,TagsViewChannelButtonDelegate,HomeToolBarDelegate>
@property (weak, nonatomic) IBOutlet HomeTopView *topView;

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;


@end
