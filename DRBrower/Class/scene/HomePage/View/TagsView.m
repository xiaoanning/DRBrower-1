//
//  TagsView.m
//  DRBrower
//
//  Created by QiQi on 2016/12/22.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "TagsView.h"

#define TAGSSV_CENTER_X self.tagsSV.center.x
@implementation TagsView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createSubViewsByTagArray:(NSArray *)tagArray {
    self.tagsSV.contentSize = CGSizeMake([tagArray count] * 70, 0);
    for (int i = 0; i < [tagArray count]; i++) {
        UIButton *channelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [channelButton setFrame:CGRectMake(70*i, 0, 70, 42)];
        [self buttonStyle:channelButton];
        [channelButton addTarget:self action:@selector(didClickSwitchChannel:) forControlEvents:UIControlEventTouchUpInside];
        channelButton.tag = i+1;
        NewsTagModel *newsTag = [tagArray objectAtIndex:i];
    
        [channelButton setTitle:newsTag.name forState:UIControlStateNormal];
        [self.tagsSV addSubview:channelButton];

    }
    UIButton *button = [[self.tagsSV subviews] firstObject];
    NSLog(@"tag=====%ld",(long)button.tag);
    [self buttonHighLightStyle:button];

}
- (void)didClickSwitchChannel:(UIButton *)button {
    
    [self changeButtonWhenPageViewScroll:button withRefresh:YES];
}

- (void)changeButtonWhenPageViewScroll:(UIButton *)button withRefresh:(BOOL)refresh
{
    for (UIButton *btn in [self.tagsSV subviews]) {
        [self buttonStyle:btn];
    }
    [self buttonHighLightStyle:button];
    if( refresh && _delegate && [_delegate respondsToSelector:@selector(touchUpChannelButtonAction:)]){
        [_delegate touchUpChannelButtonAction:button.tag];
    }
    
    CGFloat buttonCenterX = button.center.x;
    CGFloat contentOffsetX = buttonCenterX - TAGSSV_CENTER_X;
    CGFloat contentOffsetY = self.tagsSV.contentOffset.y;
    CGFloat contentSizeX = self.tagsSV.contentSize.width;
    
    if (contentOffsetX > 0 && (contentSizeX - buttonCenterX) > SCREEN_WIDTH/2) {
        [self.tagsSV setContentOffset:CGPointMake(contentOffsetX, contentOffsetY) animated:YES];
    }else if ((contentSizeX - buttonCenterX) < SCREEN_WIDTH/2) {
        [self.tagsSV setContentOffset:CGPointMake(contentSizeX - SCREEN_WIDTH, contentOffsetY) animated:YES];
    }
    
}
//button未选中
- (void)buttonStyle:(UIButton *)button{
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    button.tintColor = [UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1.0];
}

//button选中
- (void)buttonHighLightStyle:(UIButton *)button {
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    button.tintColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
}


@end
