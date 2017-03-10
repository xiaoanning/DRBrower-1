//
//  NewsPageVC.m
//  DRBrower
//
//  Created by apple on 2017/3/10.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "NewsPageVC.h"
#import "NewsTagModel.h"
#import "NewsListViewController.h"
#import "TitleLabel.h"
#import "MenuVC.h"

@interface NewsPageVC ()<MenuVCDelegate,HomeToolBarDelegate>

@property (weak, nonatomic) IBOutlet HomeToolBar *homeToolBar;
@property (strong, nonatomic) MZFormSheetPresentationViewController *formSheetController;
@property (strong, nonatomic) MZFormSheetPresentationViewController *shareFormSheetController;

@end

@implementation NewsPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"DR新闻";
    [self.navigationItem setHidesBackButton:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.showsVerticalScrollIndicator = NO;

    [self addController];
    
    [self createTitleLabel];
    
    self.homeToolBar.delegate = self;
    [self.homeToolBar setBarButton:HomeToolBarRootVCTypeHome];

    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize = CGSizeMake(contentX, 0);
    self.bigScrollView.pagingEnabled = YES;
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
    TitleLabel *lable = [self.smallScrollView.subviews firstObject];
    lable.scale = 1.0;
    self.bigScrollView.showsHorizontalScrollIndicator = NO;

}

- (void)addController{
    for (int i=0 ; i<self.tagListArray.count ;i++){
        NewsListViewController *vc1 = [[NewsListViewController alloc] init];
        vc1.model = self.tagListArray[i];
        [self addChildViewController:vc1];
    }
}

-(void)createTitleLabel {
    if (self.tagListArray.count>0) {
        for (int i = 0; i < self.tagListArray.count; i++) {
            CGFloat lblW = 70;
            CGFloat lblH = 40;
            CGFloat lblY = 0;
            CGFloat lblX = i * lblW;
            NewsTagModel *tagModel = self.tagListArray[i];
            TitleLabel *label = [[TitleLabel alloc] init];
            label.text = tagModel.name;
            label.frame = CGRectMake(lblX, lblY, lblW, lblH);
            label.font = [UIFont boldSystemFontOfSize:18];
            [self.smallScrollView addSubview:label];
            label.tag = i;
            label.userInteractionEnabled = YES;
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
        }
        self.smallScrollView.contentSize = CGSizeMake(70 * self.tagListArray.count, 0);
    }
}
/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer{
    TitleLabel *titlelable = (TitleLabel *)recognizer.view;
    CGFloat offsetX = titlelable.tag * self.bigScrollView.frame.size.width;
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.bigScrollView setContentOffset:offset animated:YES];
}
#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    
    // 滚动标题栏
    TitleLabel *titleLable = (TitleLabel *)self.smallScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    NewsListViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            TitleLabel *temlabel = self.smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:newsVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    TitleLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScrollView.subviews.count) {
        TitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}

- (void)touchUpMenuButtonAction {
    if (_delegate && [_delegate respondsToSelector:@selector(touchUpMenuButtonAction)]) {
        [_delegate touchUpMenuButtonAction];
    }
}
-(void)touchUpHomeButtonAction {
    if (_delegate && [_delegate respondsToSelector:@selector(touchUpHomeButtonAction)]) {
        [_delegate touchUpHomeButtonAction];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}
-(void)touchUpPageButtonAction {
    if (_delegate && [_delegate respondsToSelector:@selector(touchUpPageButtonAction)]) {
        [_delegate touchUpPageButtonAction];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
