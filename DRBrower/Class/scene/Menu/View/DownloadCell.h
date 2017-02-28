//
//  DownloadCell.h
//  DRBrower
//
//  Created by QiQi on 2017/2/27.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *downImg;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentAndTotalSizeLabel;//currentSize/totalSize
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
