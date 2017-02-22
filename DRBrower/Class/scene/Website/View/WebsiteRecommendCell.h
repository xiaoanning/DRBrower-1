//
//  WebsiteRecommendCell.h
//  DRBrower
//
//  Created by QiQi on 2017/1/10.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebsiteModel.h"

@interface WebsiteRecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (void)websiteRecommendCell:(WebsiteRecommendCell *)cell model:(WebsiteModel *)model;

@end
