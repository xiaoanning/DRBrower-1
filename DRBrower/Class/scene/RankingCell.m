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
    self.titleLabel.text = model.name;
    
    self.adressLabel.text = model.location;
    self.timeLabel.text = [Tools getDateString:model.updatetime];
    
    [self.zanButton setImage:[UIImage imageNamed:@"sort_zan"] forState:UIControlStateNormal];
    self.zanButton.userInteractionEnabled = YES;
    self.zanLabel.text = [NSString stringWithFormat:@"%@",model.love_num];
        
    self.informLabel.text = [NSString stringWithFormat:@"%@",model.complain_num];
    self.userCountLabel.text = [NSString stringWithFormat:@"%@",model.visit_num];
    
    [self.commentCountButton setTitle:[NSString stringWithFormat:@"%@",model.comment_num] forState:UIControlStateNormal];
    self.commentCountButton.titleLabel.textColor = [UIColor whiteColor];
    self.commentCountButton.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    self.commentCountButton.titleEdgeInsets = UIEdgeInsetsMake(0, -self.commentCountButton.imageView.frame.size.width, 0, 0);
    self.commentCountButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.commentCountButton.titleLabel.intrinsicContentSize.width);
    if ([model.comment_num integerValue] == 0) {
        self.commentCountButton.hidden = YES;
    }else {
        self.commentCountButton.hidden = NO;
    }
}
-(void)layoutSubviews {
    [super layoutSubviews];
}
#pragma mark --------RankingButtonDelegate
- (IBAction)touchUpZanButton:(id)sender {
    UIButton *button = sender;
    self.zanButton.userInteractionEnabled = NO;
    self.zanLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.zanLabel.text integerValue]+1];
    [self.zanButton setImage:[UIImage imageNamed:@"sort_zanSelected"] forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(touchUpZanButtonWithIndex:)]) {
        [_delegate touchUpZanButtonWithIndex:button.tag];
    }
}
- (IBAction)touchUpinformButton:(id)sender {
    UIButton *button = sender;
    self.informButton.userInteractionEnabled = NO;
    self.informLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.zanLabel.text integerValue]+1];
    [self.informButton setImage:[UIImage imageNamed:@"sort_informed"] forState:UIControlStateNormal];

    if (_delegate &&[_delegate respondsToSelector:@selector(touchUpInformButtonWithIndex:)]) {
        [_delegate touchUpInformButtonWithIndex:button.tag-100];
    }
}
- (IBAction)touchUpCommentButton:(id)sender {
    UIButton *button = sender;
    if (_delegate &&[_delegate respondsToSelector:@selector(touchUpInformButtonWithIndex:)]) {
        [_delegate touchUpCommentButtonWithIndex:button.tag-200];
    }
}
- (IBAction)touchUpCommentCountButton:(id)sender {
    UIButton *button = sender;
    if (_delegate &&[_delegate respondsToSelector:@selector(touchUpCommentButtonWithIndex:)]) {
        [_delegate touchUpCommentButtonWithIndex:button.tag-300];
    }
}
- (IBAction)touchUpUserButton:(id)sender {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
