//
//  ShareView.h
//  YuanZi
//
//  Created by Wang_ on 15/4/8.
//  Copyright (c) 2015年 Yuanzi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShareBlock)(SSDKPlatformType type);

@interface ShareView : UIView
@property (weak, nonatomic) IBOutlet UILabel *navLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,copy) ShareBlock shareBlock;

- (void)shareButtonClick:(ShareBlock)block;



@end
