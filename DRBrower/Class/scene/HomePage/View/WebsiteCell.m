//
//  WebsiteCell.m
//  DRBrower
//
//  Created by QiQi on 2017/1/8.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "WebsiteCell.h"
#import "WebsiteModel.h"

@implementation WebsiteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)websiteCell:(WebsiteCell *)cell model:(WebsiteModel *)model {
    if (!model.icon&&!model.name) {
        self.iconView.image = [UIImage imageNamed:@"add"];
        self.nameLabel.text = NSLocalizedString(@"添加", nil);
    }else {
        self.nameLabel.text = model.name;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon]
                         placeholderImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[NSURL URLWithString:model.icon] absoluteString]]completed:nil];

    }
}

@end
