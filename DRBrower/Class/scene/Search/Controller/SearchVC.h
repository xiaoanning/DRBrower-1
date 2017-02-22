//
//  SearchVC.h
//  DRBrower
//
//  Created by QiQi on 2017/1/4.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PYSearch.h"

@interface SearchVC : UIViewController

@property (nonatomic, strong)NSString *searchText;
@property (nonatomic, strong)PYSearchViewController *searchViewController;

@end
