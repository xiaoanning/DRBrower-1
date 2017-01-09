//
//  HomeTopView.h
//  DRBrower
//
//  Created by QiQi on 2016/12/20.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebsiteModel;

@protocol HomeTopViewDelegate <NSObject>

- (void)touchUpSearchButtonAction;
- (void)touchUpQRcodeButtonAction;

-(void)websiteViewSelectWithWebsite:(WebsiteModel *)website;


@end

@interface HomeTopView : UIView

@property (nonatomic, assign)id<HomeTopViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *websiteCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *websitePageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *websitePageControlHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *websiteCollectionViewHeight;

@property (nonatomic, strong) NSMutableArray *websiteArray;

@end
