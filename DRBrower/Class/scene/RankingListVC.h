//
//  RankingListVC.h
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortTagModel.h"


@interface RankingListVC : UIViewController

@property (retain , nonatomic ) UINavigationController * navigationController ;

@property ( nonatomic , assign ) NSInteger index ;
@property ( nonatomic , retain ) SortTagModel * tagModel ;
@property ( nonatomic , copy ) NSString *sort ;

@end
