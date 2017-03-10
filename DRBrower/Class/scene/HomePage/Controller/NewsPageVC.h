//
//  NewsPageVC.h
//  DRBrower
//
//  Created by apple on 2017/3/10.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsMenuDelegate <NSObject>
- (void)touchUpMenuButtonAction;
- (void)touchUpHomeButtonAction;
- (void)touchUpPageButtonAction;
@end

@interface NewsPageVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (nonatomic,strong) NSArray *tagListArray;

@property (nonatomic,weak) id<NewsMenuDelegate>delegate;
@end
