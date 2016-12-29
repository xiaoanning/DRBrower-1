//
//  ThreePicCell.h
//  DRBrower
//
//  Created by QiQi on 2016/12/22.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

@interface ThreePicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutletCollection(DRImageView) NSArray *imgsImageView;


- (void)threePicCell:(ThreePicCell *)cell model:(NewsModel *)model;


@end
