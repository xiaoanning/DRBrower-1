//
//  RecordCell.h
//  DRBrower
//
//  Created by QiQi on 2017/2/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecordModel;

@interface RecordCell : SWTableViewCell<SWTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

- (void)recordCell:(RecordCell *)cell model:(RecordModel *)model;


@end
