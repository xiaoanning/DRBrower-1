//
//  DownloadCell.h
//  DRBrower
//
//  Created by QiQi on 2017/2/27.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DownloadModel;

@protocol DownloadCellDelegate <NSObject>
@optional
- (void)downloadStateCompleted:(DownloadModel *)download;

@end

@interface DownloadCell : SWTableViewCell<SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *downImg;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentAndTotalSizeLabel;//currentSize/totalSize
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (nonatomic, assign)id<DownloadCellDelegate>downlaodDelegate;


- (void)downloadCell:(DownloadCell *)cell model:(DownloadModel *)model;


@end
