//
//  OnePicCell.m
//  WebBrowser
//
//  Created by QiQi on 2016/12/17.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "OnePicCell.h"
#import "imgsModel.h"
#import "NewsModel.h"

@implementation OnePicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)onePicCell:(OnePicCell *)cell model:(NewsModel *)model {
   
    self.titleLabel.text = model.title;
    ImgsModel *img = model.imgs[0];
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:img.url]
                         placeholderImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[NSURL URLWithString:img.url] absoluteString]]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             [self.imgImageView cutImage:image];
                         }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
