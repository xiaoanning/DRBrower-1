//
//  DownloadCell.m
//  DRBrower
//
//  Created by QiQi on 2017/2/27.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DownloadCell.h"
#import "DownloadModel.h"
#import "MCDownloadManager.h"

@implementation DownloadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)downloadCell:(DownloadCell *)cell model:(DownloadModel *)model {
    self.titleLabel.text = model.title;

    MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:model.url];
    
    self.progressView.progress = receipt.progress.fractionCompleted;
    
    if (receipt.state == MCDownloadStateDownloading) {
        //        [self.button setTitle:@"停止" forState:UIControlStateNormal];
    }else if (receipt.state == MCDownloadStateCompleted) {
        //        [self.button setTitle:@"播放" forState:UIControlStateNormal];
    }else {
        //        [self.button setTitle:@"下载" forState:UIControlStateNormal];
    }
    
    receipt.progressBlock = ^(NSProgress * _Nonnull downloadProgress,MCDownloadReceipt *receipt) {
        if ([receipt.url isEqualToString:model.url]) {
            self.progressView.progress = downloadProgress.fractionCompleted ;
            self.currentAndTotalSizeLabel.text = [NSString stringWithFormat:@"%.1fMB/%.1fMB", downloadProgress.completedUnitCount/1024.0/1024, downloadProgress.totalUnitCount/1024.0/1024];
            self.stateLabel.text = [NSString stringWithFormat:@"%@/s", receipt.speed];
        }
    };
    
    receipt.successBlock = ^(NSURLRequest * _Nullablerequest, NSHTTPURLResponse * _Nullableresponse, NSURL * _NonnullfilePath) {
        
        if(_downlaodDelegate && [_downlaodDelegate respondsToSelector:@selector(downloadStateCompleted:)]){
            [_downlaodDelegate downloadStateCompleted:model];
        }
    };
    
    receipt.failureBlock = ^(NSURLRequest * _Nullable request, NSHTTPURLResponse * _Nullable response,  NSError * _Nonnull error) {
        //        [self.button setTitle:@"下载" forState:UIControlStateNormal];
    };
    

}

-(void)seell{

      MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:@"http://download.2166.com/video/gongfuyujia.mp4"];
    
    self.titleLabel.text = receipt.truename;
    self.progressView.progress = receipt.progress.fractionCompleted;

    if (receipt.state == MCDownloadStateDownloading) {
//        [self.button setTitle:@"停止" forState:UIControlStateNormal];
    }else if (receipt.state == MCDownloadStateCompleted) {
//        [self.button setTitle:@"播放" forState:UIControlStateNormal];
    }else {
//        [self.button setTitle:@"下载" forState:UIControlStateNormal];
    }
    
    receipt.progressBlock = ^(NSProgress * _Nonnull downloadProgress,MCDownloadReceipt *receipt) {
        if ([receipt.url isEqualToString:@"http://download.2166.com/video/gongfuyujia.mp4"]) {
            self.progressView.progress = downloadProgress.fractionCompleted ;
            self.currentAndTotalSizeLabel.text = [NSString stringWithFormat:@"%.1fMB/%.1fMB", downloadProgress.completedUnitCount/1024.0/1024, downloadProgress.totalUnitCount/1024.0/1024];
            self.stateLabel.text = [NSString stringWithFormat:@"%@/s", receipt.speed];
        }
    };
    
    receipt.successBlock = ^(NSURLRequest * _Nullablerequest, NSHTTPURLResponse * _Nullableresponse, NSURL * _NonnullfilePath) {
//        [self.button setTitle:@"播放" forState:UIControlStateNormal];
    };
    
    receipt.failureBlock = ^(NSURLRequest * _Nullable request, NSHTTPURLResponse * _Nullable response,  NSError * _Nonnull error) {
//        [self.button setTitle:@"下载" forState:UIControlStateNormal];
    };
    
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
