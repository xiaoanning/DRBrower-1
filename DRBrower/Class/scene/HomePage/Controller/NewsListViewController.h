//
//  NewsListViewController.h
//  DRBrower
//
//  Created by apple on 17/2/17.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTopView.h"
#import "TagsView.h"
#import "HomeToolBar.h"

#import "PYSearch.h"


@interface NewsListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,TagsViewChannelButtonDelegate,HomeToolBarDelegate,PYSearchViewControllerDelegate,HomeTopViewDelegate>

@property (retain, nonatomic)  UITableView *homeTableView;

@property ( nonatomic , assign ) NSInteger index ;
@property ( nonatomic , retain ) NewsTagModel * model ;

@end
