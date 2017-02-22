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
-(void)touchUpPraiseButtonActionWithIndex:(NSInteger)index;
-(void)touchUpInformButtonActionWithIndex:(NSInteger)index;
-(void)touchUpCommentButtonActionWithIndex:(NSInteger)index;
-(void)touchUpUserButtonActionWithIndex:(NSInteger)index;
@end

@interface RankingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UIButton *informButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *userButton;

@property (nonatomic,weak) id<RankingButtonDelegate>delegate;

-(void)rankingCell:(RankingCell *)cell model:(SortModel *)model index:(NSInteger)index;
@end
