//
//  RankingCell.h
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortModel.h"

@protocol RankingButtonDelegate <NSObject>
-(void)touchUpZanButtonWithIndex:(NSInteger)index;
-(void)touchUpInformButtonWithIndex:(NSInteger)index;
-(void)touchUpCommentButtonWithIndex:(NSInteger)index;
-(void)touchUpUserButtonWithIndex:(NSInteger)index;
@end

@interface RankingCell : UITableViewCell

@property (nonatomic,weak) id<RankingButtonDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UILabel *zanLabel;
@property (weak, nonatomic) IBOutlet UIButton *informButton;
@property (weak, nonatomic) IBOutlet UILabel *informLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *commentCountButton;
@property (weak, nonatomic) IBOutlet UIButton *userButton;
@property (weak, nonatomic) IBOutlet UILabel *userCountLabel;

-(void)rankingCell:(RankingCell *)cell model:(SortModel *)model index:(NSInteger)index;


@end
