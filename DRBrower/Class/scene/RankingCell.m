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
    
    self.nameLabel.text = model.name;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    
    self.timeLabel.text = [Tools getDateString:model.updatetime];
    
    self.adressLabel.text = model.location;
    
    UIImage *img = [UIImage imageNamed:@"icon_dianzan.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.praiseButton setTitle:[NSString stringWithFormat:@"%@",model.love_num] forState:UIControlStateNormal];
    [self.praiseButton setImage:img forState:UIControlStateNormal];
    self.praiseButton.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,5);

    [self.informButton setTitle:@"举报" forState:UIControlStateNormal];
    [self.informButton setImage:[self imageAlwaysOriginalWithImageName:@"icon_jibao.png"] forState:UIControlStateNormal];
    self.informButton.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,5);
    
    [self.commentButton setTitle:[NSString stringWithFormat:@"%@",model.comment_num] forState:UIControlStateNormal];
    [self.commentButton setImage:[self imageAlwaysOriginalWithImageName:@"icon_comment.png"] forState:UIControlStateNormal];
    self.commentButton.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,5);
    
    [self.userButton setTitle:[NSString stringWithFormat:@"%@",model.visit_num] forState:UIControlStateNormal];
    [self.userButton setImage:[self imageAlwaysOriginalWithImageName:@"icon_guankan.png"] forState:UIControlStateNormal];
    self.userButton.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,5);
}

- (IBAction)praiseButtonAction:(id)sender {
    [self.praiseButton setImage:[self imageAlwaysOriginalWithImageName:@"icon_dianzan2.png"] forState:UIControlStateNormal];
    self.praiseButton.enabled = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchUpPraiseButtonActionWithIndex:)]) {
        [self.delegate touchUpPraiseButtonActionWithIndex:currentIndex];
    }
}
- (IBAction)informButtonAction:(id)sender {
    [self.informButton setImage:[self imageAlwaysOriginalWithImageName:@"icon_jibao2.png"] forState:UIControlStateNormal];
    self.informButton.enabled = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchUpInformButtonActionWithIndex:)]) {
        [self.delegate touchUpInformButtonActionWithIndex:currentIndex];
    }
}
- (IBAction)commentButtonAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchUpCommentButtonActionWithIndex:)]) {
        [self.delegate touchUpCommentButtonActionWithIndex:currentIndex];
    }
}
- (IBAction)userButtonAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchUpUserButtonActionWithIndex:)]) {
        [self.delegate touchUpUserButtonActionWithIndex:currentIndex];
    }
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
