//
//  MenuVC.h
//  DRBrower
//
//  Created by QiQi on 2017/1/17.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MenuVCRootVCType) {
    MenuVCRootVCTypeUnknown = 0,
    MenuVCRootVCTypeHome,
    MenuVCRootVCTypeSearch
};

@protocol MenuVCDelegate <NSObject>
@optional
- (void)touchUpCollectButtonAction;
- (void)touchUpFullScreenButtonAction:(BOOL)isfull;
- (void)touchUpRefreshDataButtonAction;
- (void)touchUpRecordButtonAction;
- (void)touchUpMoreButtonAction;
- (void)touchUpSpitButtonAction;
- (void)touchUpServiceButtonAction;
- (void)touchUpIconImageView;
@end

@interface MenuVC : UIViewController

@property (nonatomic, assign)id<MenuVCDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (assign, nonatomic) MenuVCRootVCType rootVCType;

@end
