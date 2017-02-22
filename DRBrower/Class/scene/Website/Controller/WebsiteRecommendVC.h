//
//  WebsiteRecommendVC.h
//  DRBrower
//
//  Created by QiQi on 2017/1/9.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebsiteRecommendVC : UIViewController<UITableViewDelegate, UITableViewDataSource,AXStretchableSubViewControllerViewSource>

@property (strong, nonatomic) NSMutableArray *websiteArray;

@end
