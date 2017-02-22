//
//  DRImageView.h
//  DRBrower
//
//  Created by QiQi on 2016/12/23.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRImageView : UIImageView

@property (nonatomic, assign)CGSize drImageViewSize;

//- (void)cutImage:(UIImage*)image scale:(CGFloat)scale;
//等比压缩裁剪
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

@end
