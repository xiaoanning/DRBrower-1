//
//  OnePicCell.h
//  WebBrowser
//
//  Created by QiQi on 2016/12/17.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

@interface OnePicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet DRImageView *imgImageView;

- (void)onePicCell:(OnePicCell *)cell model:(NewsModel *)model;


@end
