//
//  TagsView.h
//  DRBrower
//
//  Created by QiQi on 2016/12/22.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsTagModel.h"

@protocol TagsViewChannelButtonDelegate <NSObject>
@optional
- (void)touchUpChannelButtonAction:(NSInteger)buttonTags;

@end

@interface TagsView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *tagsSV;

@property (nonatomic, assign)id<TagsViewChannelButtonDelegate>delegate;

- (void)createSubViewsByTagArray:(NSArray *)tagArray;

- (void)changeButtonWhenPageViewScroll:(UIButton *)button withRefresh:(BOOL)refresh;

@end
