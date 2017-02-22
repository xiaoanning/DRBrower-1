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
    
        UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)];
        longPressGesture.minimumPressDuration=0.5f;//设置长按 时间
        [self.contentView addGestureRecognizer:longPressGesture];
        
    
    // Initialization code
}

- (void)websiteCell:(WebsiteCell *)cell model:(WebsiteModel *)model {
    if (model.icon&&model.name) {
        self.nameLabel.text = model.name;
        if ([model.icon isEqualToString:@"add"]) {
            self.iconView.image = [UIImage imageNamed:model.icon];
        }else {
            
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon]
                             placeholderImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[NSURL URLWithString:model.icon] absoluteString]]completed:nil];
        }

    } else {
        self.nameLabel.text = @"";
        self.iconView.image = nil;
    }
}

- (void)handleLongPressGesture:(UIGestureRecognizer *)gesture {
    if(_delegate && [_delegate respondsToSelector:@selector(longPressGesture:)]){
        [_delegate longPressGesture:self.model];
    }
}

@end
