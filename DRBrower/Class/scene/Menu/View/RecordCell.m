//
//  RecordCell.m
//  DRBrower
//
//  Created by QiQi on 2017/2/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)recordCell:(RecordCell *)cell model:(RecordModel *)model {
    self.titleLabel.text = model.title;
    self.urlLabel.text = model.url;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
