//
//  WebsiteCell.h
//  DRBrower
//
//  Created by QiQi on 2017/1/8.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebsiteModel;

@protocol WebsiteCellDelegate <NSObject>
@optional
- (void)longPressGesture:(WebsiteModel *)model;

@end

@interface WebsiteCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) WebsiteModel *model;
@property (assign, nonatomic)id<WebsiteCellDelegate>delegate;

- (void)websiteCell:(WebsiteCell *)cell model:(WebsiteModel *)model;


@end
