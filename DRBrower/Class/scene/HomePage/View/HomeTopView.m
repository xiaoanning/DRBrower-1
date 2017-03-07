//
//  HomeTopView.m
//  DRBrower
//
//  Created by QiQi on 2016/12/20.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "HomeTopView.h"
#include "CSStickyHeaderFlowLayout.h"
#import "WebsiteCell.h"
#import "WebsiteModel.h"
#import "HomeTopViewLayout.h"
#import "WeatherModel.h"

static NSString *const websiteCellIdentifier = @"WebsiteCell";
@interface HomeTopView()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>{
    
}
@end
@implementation HomeTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)weatherHeader:(HomeTopView *)header model:(WeatherModel *)model {
    self.weatherLabel.text = model.weather;
    self.temperatureLabel.text = [model.temperature stringByAppendingString:@"°"];
    self.pmLabel.text = model.pm25;
    self.placeLabel.text = model.currentCity;
    
    int parseInt = [model.pm25 intValue];
    if (0 <= parseInt && parseInt < 50) {
        self.airQualityLabel.text = NSLocalizedString(@"空气优", nil);
        self.pmLabel.backgroundColor = colorWithvalue(@"39e0d6");
    } else if (50 <= parseInt && parseInt < 100) {
        self.airQualityLabel.text = NSLocalizedString(@"空气良", nil);
        self.pmLabel.backgroundColor = colorWithvalue(@"6ce324");
    } else if (100 <= parseInt && parseInt < 150) {
        self.airQualityLabel.text = NSLocalizedString(@"轻度污染", nil);
        self.pmLabel.backgroundColor = colorWithvalue(@"e7cc16");
    } else if (150 <= parseInt && parseInt < 200) {
        self.airQualityLabel.text = NSLocalizedString(@"中度污染", nil);
        self.pmLabel.backgroundColor = colorWithvalue(@"e67c27");
    } else if (200 <= parseInt && parseInt < 300) {
        self.airQualityLabel.text = NSLocalizedString(@"重度污染", nil);
        self.pmLabel.backgroundColor = colorWithvalue(@"c92b41");
    } else if (parseInt >= 300) {
        self.airQualityLabel.text = NSLocalizedString(@"严重污染", nil);
        self.pmLabel.backgroundColor = colorWithvalue(@"8827c5");
    }
    
    if ([model.weather containsString:NSLocalizedString(@"晴", nil)]) {
        self.weatherImage.image = [UIImage imageNamed:@"weather_fine"];
    }else if ([model.weather containsString:NSLocalizedString(@"云", nil)]) {
        self.weatherImage.image = [UIImage imageNamed:@"weather_cloudy"];
    }else if ([model.weather containsString:NSLocalizedString(@"雨", nil)]) {
        self.weatherImage.image = [UIImage imageNamed:@"weather_light_rain"];
    }else if ([model.weather containsString:NSLocalizedString(@"霾", nil)]) {
        self.weatherImage.image = [UIImage imageNamed:@"weather_haze"];
    }else if ([model.weather containsString:NSLocalizedString(@"阴", nil)]) {
        self.weatherImage.image = [UIImage imageNamed:@"weather_overcast"];
    }else if ([model.weather containsString:NSLocalizedString(@"雪", nil)]) {
        self.weatherImage.image = [UIImage imageNamed:@"weather_Light_Snow"];
    }else {
        self.weatherImage.image = [UIImage imageNamed:@"weather_cloudy"];
    }
    
    if (model.pm25 == nil) {
        self.airQualityLabel.text = @"";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.websiteCollectionView.dataSource = self;
    self.websiteCollectionView.delegate = self;
    
    [self.websiteCollectionView registerNib:[UINib nibWithNibName:@"WebsiteCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:websiteCellIdentifier];
    [self data];
    [self reloadPageControl];
}
- (void)data {
    self.websiteArray = [DRLocaldData achieveWebsiteData];
    [(HomeTopViewLayout *)self.websiteCollectionView.collectionViewLayout setDefectListModel:self.websiteArray] ;
    [self reloadPageControl];
    
}

- (void)reloadPageControl {
    if ([Tools isRemainder:self.websiteArray] == YES) {
        NSInteger num = [self.websiteArray count]/10;
        if([self.websiteArray count]%10 > 0) {
            self.websitePageControl.numberOfPages = num + 1;
        }
        else{
            self.websitePageControl.numberOfPages = num;
        }
        
    }else {
        self.websitePageControlHeight.constant = 0;
    }
}

#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return self.websiteArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WebsiteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:websiteCellIdentifier forIndexPath:indexPath];
    WebsiteModel *website = self.websiteArray[indexPath.row];
    cell.model = website;
    cell.delegate = self;
    [cell websiteCell:cell model:website];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    WebsiteModel *website = self.websiteArray[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(websiteViewSelectWithWebsite:)]) {
        [_delegate websiteViewSelectWithWebsite:website];
    }
}

#pragma  mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/5.0, self.websiteCollectionViewHeight.constant/2);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    self.websitePageControl.currentPage=(NSInteger)(offsetX/SCREEN_WIDTH);
}

- (IBAction)didclickSearchButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpSearchButtonAction)]){
        [_delegate touchUpSearchButtonAction];
    }
}

- (IBAction)didClickQRcodeButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpQRcodeButtonAction)]){
        [_delegate touchUpQRcodeButtonAction];
    }
}

- (IBAction)didClickURLButtonAciton:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpButtonShowDetail:)]){
        [_delegate touchUpButtonShowDetail:URL_123HAOURL];
    }
}

- (IBAction)didClickNovelButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpButtonShowDetail:)]){
        [_delegate touchUpButtonShowDetail:URL_NOVEL];
    }
}

- (IBAction)didClickLadyButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpButtonShowDetail:)]){
        [_delegate touchUpButtonShowDetail:URL_LADY];
    }
}
- (IBAction)didClickJokesButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpButtonShowDetail:)]){
        [_delegate touchUpButtonShowDetail:URL_JOKES];
    }
}

- (IBAction)touchUpSortButton:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(touchUpSortButtonAction)]) {
        [_delegate touchUpSortButtonAction];
    }
}

- (void)longPressGesture:(WebsiteModel *)model {

        if(_delegate && [_delegate respondsToSelector:@selector(homeTopViewPresentView:)]){
            [_delegate homeTopViewPresentView:model];
        }

}




@end
