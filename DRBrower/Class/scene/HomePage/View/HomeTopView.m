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

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.websiteCollectionView.dataSource = self;
    self.websiteCollectionView.delegate = self;
    
    [self.websiteCollectionView registerNib:[UINib nibWithNibName:@"WebsiteCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:websiteCellIdentifier];
    [self getWebsiteData];
}

//获取网站
- (void)getWebsiteData {
    [WebsiteModel getWebsiteUrl:[NSString stringWithFormat:@"%@%@",BASE_URL,URL_GETWEBSITE]
                     parameters:@{}
                          block:^(WebsiteListModel *websiteList, NSError *error) {
                              //                              self.websiteArray
                              self.websiteArray = websiteList.data;

                              WebsiteModel *addWebsite = [[WebsiteModel alloc] init];
                              [self.websiteArray addObject:addWebsite];
                              
                              if ([self isRemainder] == YES) {
                                  self.websitePageControl.numberOfPages = [self.websiteArray count]/10 + 1;
                              }else {
                                  self.websitePageControl.numberOfPages = [self.websiteArray count]/10;
                              }
                              
                              [self.websiteCollectionView reloadData];
                              
                              NSLog(@"websiteList = %@",websiteList);
                          }];
    
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
    return CGSizeMake(SCREEN_WIDTH/5.0, (self.websiteCollectionViewHeight.constant-20)/2);
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

- (BOOL)isRemainder {
    if ([self.websiteArray count]%10 > 0) {
        return YES;
    }else {
        return NO;
    }
}

@end
