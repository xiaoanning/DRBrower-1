//
//  CommentListCell.m
//  DRBrower
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "CommentListCell.h"

@implementation CommentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)commentListCell:(CommentListCell *)cell model:(CommentModel *)model index:(NSInteger)index {
//    [self.iconImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"CircleFriends"]];
//    self.nameLabel.text =
    self.timeLabel.text = [Tools getDateString:model.createtime];
    self.contentLabel.text = model.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
