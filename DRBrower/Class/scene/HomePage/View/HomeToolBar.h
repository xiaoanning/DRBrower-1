//
//  HomeToolBar.h
//  DRBrower
//
//  Created by QiQi on 2016/12/24.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HomeToolBarRootVCType) {
    HomeToolBarRootVCTypeUnknown = 0,
    HomeToolBarRootVCTypeHome,
    HomeToolBarRootVCTypeSearch
};

@protocol HomeToolBarDelegate <NSObject>
@optional
- (void)touchUpHomeButtonAction;
- (void)touchUpMenuButtonAction;
- (void)touchUpBackButtonAction;
- (void)touchUpGoButtonActionr;
- (void)touchUpPageButtonAction;

@end

@interface HomeToolBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@property (weak, nonatomic) IBOutlet UIButton *pageBtn;

@property (assign, nonatomic)id<HomeToolBarDelegate>delegate;
- (void)setBarButton:(HomeToolBarRootVCType)rootVCType;

@end
