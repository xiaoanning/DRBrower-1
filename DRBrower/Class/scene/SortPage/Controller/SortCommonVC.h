//
//  SortCommonVC.h
//  DRBrower
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortRootVC.h"
#import "SortTagModel.h"

@interface SortCommonVC : UIViewController
@property (nonatomic,strong) SortTagModel *sortTagModel;
@property (nonatomic,strong) SortRootVC *sortRootVC;

@property (nonatomic,strong) NSMutableArray *sortListArray;

@property (nonatomic,strong) UITableView *tableView;
//获取排行列表
- (void)getSortListByModel:(SortTagModel *)model type:(NSString *)type sort:(NSString *)sort;
//上拉刷新
- (void)loadMoreData;
@end
