//
//  UIImage+DRImageClip.m
//  DRBrower
//
//  Created by QiQi on 2017/2/21.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "UIImage+DRImageClip.h"

@implementation UIImage (DRImageClip)

+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imgData = UIImageJPEGRepresentation(newImage, 1);
    NSInteger len = imgData.length / 1024;
    if (len > 26) {
        NSData *data = UIImageJPEGRepresentation(newImage, 0.1);
        UIImage *image = [UIImage imageWithData:data];
        return image;
    }
    return newImage;
}

@end
