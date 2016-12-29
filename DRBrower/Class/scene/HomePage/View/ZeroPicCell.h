//
//  ZeroPicCell.h
//  DRBrower
//
//  Created by QiQi on 2016/12/23.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

@interface ZeroPicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)zeroPicCell:(ZeroPicCell *)cell model:(NewsModel *)model;


@end
