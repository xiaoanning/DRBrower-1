//
//  HomeToolBar.h
//  DRBrower
//
//  Created by QiQi on 2016/12/24.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeToolBarDelegate <NSObject>

- (void)touchUpHomeButtonAction;
- (void)touchUpMenuButtonAction;
@end

@interface HomeToolBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *homrButton;
@property (weak, nonatomic) IBOutlet UIButton *menu;

@property (assign, nonatomic)id<HomeToolBarDelegate>delegate;

@end
