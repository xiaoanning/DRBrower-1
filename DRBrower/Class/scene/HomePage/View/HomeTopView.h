//
//  HomeTopView.h
//  DRBrower
//
//  Created by QiQi on 2016/12/20.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebsiteCell.h"
@class WebsiteModel;
@class WeatherModel;

@protocol HomeTopViewDelegate <NSObject>
@optional
- (void)touchUpSearchButtonAction;
- (void)touchUpQRcodeButtonAction;
- (void)touchUpSortButtonAction;

- (void)websiteViewSelectWithWebsite:(WebsiteModel *)website;
- (void)homeTopViewpresentView:(WebsiteModel *)model;

@end

@interface HomeTopView : UIView<WebsiteCellDelegate>

@property (nonatomic, assign)id<HomeTopViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *websiteCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *websitePageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *websitePageControlHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *websiteCollectionViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *airQualityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pmLabel;

@property (nonatomic, strong) NSMutableArray *websiteArray;

- (void)weatherHeader:(HomeTopView *)header model:(WeatherModel *)model;


@end
