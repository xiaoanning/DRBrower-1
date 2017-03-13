//
//  NavView.h
//  DRBrower
//
//  Created by QiQi on 2017/3/12.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NavViewDelegate <NSObject>
@optional
- (void)touchUpNavSearchButtonAction;
- (void)touchUpNavQRcodeButtonAction;


@end

@interface NavView : UIView

@property (nonatomic, assign)id<NavViewDelegate>delegate;


- (void)navAlphaY:(CGFloat)y;
@end
