//
//  ThreePicCell.m
//  DRBrower
//
//  Created by QiQi on 2016/12/22.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "ThreePicCell.h"
#import "imgsModel.h"
#import "NewsModel.h"

@implementation ThreePicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)threePicCell:(ThreePicCell *)cell model:(NewsModel *)model {
    
    self.titleLabel.text = model.title;
    for (int i = 0;i<[self.imgsImageView count]; i++) {
        DRImageView *imageView = self.imgsImageView[i];
        ImgsModel *img =model.imgs[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:img.url] placeholderImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[NSURL URLWithString:img.url] absoluteString]]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [imageView cutImage:image];
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
