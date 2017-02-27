//
//  ShareView.m
//  YuanZi
//
//  Created by Wang_ on 15/4/8.
//  Copyright (c) 2015年 Yuanzi. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()

@property (weak, nonatomic) IBOutlet UIView *friendCircleView;
@property (weak, nonatomic) IBOutlet UIView *QQView;
@property (weak, nonatomic) IBOutlet UIView *WechatView;

@end
@implementation ShareView


- (void)shareButtonClick:(ShareBlock)block {
    _shareBlock = [block copy];
}

- (IBAction)friendCircleButtonAction:(id)sender {
    if (_shareBlock) {
        _shareBlock(SSDKPlatformSubTypeWechatTimeline);
    }
}

- (IBAction)weiChatButtonAction:(id)sender {
    if (_shareBlock) {
        _shareBlock(SSDKPlatformSubTypeWechatSession);
    }
}

- (IBAction)qqButtonAction:(id)sender {
    if (_shareBlock) {
        _shareBlock(SSDKPlatformTypeQQ);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
