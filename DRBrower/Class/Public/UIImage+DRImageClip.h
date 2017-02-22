//
//  UIImage+DRImageClip.h
//  DRBrower
//
//  Created by QiQi on 2017/2/21.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DRImageClip)

+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
