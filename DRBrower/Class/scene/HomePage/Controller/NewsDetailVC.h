//
//  NewsDetailVC.h
//  DRBrower
//
//  Created by QiQi on 2016/12/23.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "SortModel.h"

@interface NewsDetailVC : UIViewController

@property (nonatomic, strong)NewsModel *newsModel;
@property (nonatomic, strong)SortModel *sortModel;

@end
