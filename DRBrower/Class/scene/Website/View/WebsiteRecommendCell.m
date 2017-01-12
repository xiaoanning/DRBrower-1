//
//  WebsiteRecommendCell.m
//  DRBrower
//
//  Created by QiQi on 2017/1/10.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "WebsiteRecommendCell.h"

#define STATUS_EXIST @"已添加";
//#define STATUS_WITHOUT 

@implementation WebsiteRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)websiteRecommendCell:(WebsiteRecommendCell *)cell model:(WebsiteModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]
                     placeholderImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[NSURL URLWithString:model.icon] absoluteString]]completed:nil];
    self.nameLabel.text = model.name;
    self.urlLabel.text = model.url;
    NSMutableArray *array = [DRLocaldData achieveWebsiteData];
    if ([array containsObject:model]) {
        self.statusLabel.text = STATUS_EXIST;
    }else {
        self.statusLabel.text = nil;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
