//
//  DRImageView.m
//  DRBrower
//
//  Created by QiQi on 2016/12/23.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "DRImageView.h"

@implementation DRImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGSize)drImageViewSize {
    _drImageViewSize = self.frame.size;
    return _drImageViewSize;
}

- (void)cutImage:(UIImage*)image
{

    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (self.frame.size.width / self.frame.size.height))
    {
        newSize.width = image.size.width;
        
        newSize.height = image.size.width * self.frame.size.height / self.frame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else
    {
        newSize.height = image.size.height;
        
        newSize.width = image.size.height * self.frame.size.width / self.frame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    }
    self.image = [UIImage imageWithCGImage:imageRef];
}




@end
