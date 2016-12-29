//
//  ZeroPicCell.m
//  DRBrower
//
//  Created by QiQi on 2016/12/23.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "ZeroPicCell.h"
#import "NewsModel.h"

@implementation ZeroPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)zeroPicCell:(ZeroPicCell *)cell model:(NewsModel *)model {
    self.titleLabel.text = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
