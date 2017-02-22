//
//  RankingCell.m
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "RankingCell.h"

@implementation RankingCell {
    NSInteger currentIndex;//当前cell下标
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)rankingCell:(RankingCell *)cell model:(SortModel *)model index:(NSInteger)index{
    currentIndex = index;
    self.zanLabel.text = [NSString stringWithFormat:@"%@",model.love_num];
    self.informLabel.text = [NSString stringWithFormat:@"%@",model.complain_num];
    self.userLabel.text = [NSString stringWithFormat:@"%@",model.visit_num];
}

//防止图片颜色变化
-(UIImage *)imageAlwaysOriginalWithImageName:(NSString *)nameString {
    UIImage *image = [UIImage imageNamed:nameString];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
