//
//  RankingViewController.m
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "RankingViewController.h"
#import "RankingListVC.h"
#import "SortTagModel.h"
#import "SortModel.h"

@interface RankingViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate> {
    CGFloat topSpace;
    int *sortIndex;//当前
    UIView *bottomView;
}
@property (nonatomic,strong) UIPageViewController *pageVC;
@property (nonatomic,strong) NSArray *sortTagArray;
@property (nonatomic,strong) SortTagModel *tagModel;
@property (nonatomic,strong) UITableView *smallTableView;
@property (nonatomic,strong) NSArray *sTitleArray;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sortTagArray = [NSArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"热度排行";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    topSpace = 60;
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self creaetRightButtonItem];
    
    [self getSortTag];
}
- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)creaetRightButtonItem {
    UIButton *rightBar = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBar setImage:[UIImage imageNamed:@"sort_switch"] forState:UIControlStateNormal];
    rightBar.frame = CGRectMake(0, 0, 30, 30);
    [rightBar addTarget:self action:@selector(touchUpInsideRightButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBar];
    [self.navigationItem setRightBarButtonItem:rightItem];
}
-(void)touchUpInsideRightButton:(UIButton *)button {
    [self createTableView];
}
//获取排行分类标签
-(void)getSortTag {
    [SortTagModel getSortTagUrl:[NSString stringWithFormat:@"%@%@",BASE_URL,URL_GETSORTTAG] parameters:@{} block:^(SortTagListModel *newsList, NSError *error) {
        self.sortTagArray = newsList.data;
        
        [self createTopButtonByArray:self.sortTagArray];
        
        [self createPageView];

    }];
}

-(void)createTopButtonByArray:(NSArray *)array {
    bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, 0, SCREEN_WIDTH, topSpace);
    [self.view addSubview:bottomView];
    
    CGFloat buttonWidth = SCREEN_WIDTH/3;
    for (int i = 0; i<array.count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(buttonWidth*i, 0, buttonWidth, topSpace);
        titleButton.backgroundColor = [UIColor whiteColor];
        
        SortTagModel *tagModel = array[i];
        [titleButton setTitle:tagModel.name forState:UIControlStateNormal];
        
        titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [bottomView addSubview:titleButton];
        titleButton.tag = i+1;
        [titleButton addTarget:self action:@selector(touchUpTopButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self buttonHighLightStyle:[[bottomView subviews] firstObject]];
}
//button未选中
- (void)buttonStyle:(UIButton *)button{
    button.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
//button选中
- (void)buttonHighLightStyle:(UIButton *)button {
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    [button setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
}
//button点击
-(void)touchUpTopButton:(UIButton *)button {
    for (int i = 0; i < bottomView.subviews.count; i++) {
        UIButton *button = bottomView.subviews[i];
        [self buttonStyle:button];
    }
    [self buttonHighLightStyle:button];
    
    NSInteger currentIndex = button.tag;
    
    SortTagModel *sortTagModel = self.sortTagArray[currentIndex-1];

    UIPageViewControllerNavigationDirection direction ;
    if ([self.sortTagArray indexOfObject:sortTagModel] == [self.sortTagArray indexOfObject:self.tagModel] )
    {
        return ;
    }else if ([self.sortTagArray indexOfObject:sortTagModel] > [self.sortTagArray indexOfObject:self.tagModel])
    {
        direction = UIPageViewControllerNavigationDirectionForward ;
    }else
    {
        direction = UIPageViewControllerNavigationDirectionReverse ;
    }
    
    RankingListVC * vc = [[RankingListVC alloc]init] ;
    vc.navigationController = self.navigationController;
    vc.index = currentIndex-1;
    vc.tagModel = self.sortTagArray[vc.index];
    [_pageVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.tagModel = sortTagModel;

}


-(void)createPageView {
    if (_pageVC == nil) {
        _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageVC.delegate = self ;
        _pageVC.dataSource = self ;
        _pageVC.view.frame = CGRectMake(0, topSpace, SCREEN_WIDTH, SCREEN_HEIGHT - topSpace);
        [self.view addSubview:_pageVC.view];
        [self.view bringSubviewToFront:_pageVC.view];
        
        RankingListVC * vc = [[RankingListVC alloc]init] ;
        vc.navigationController = self.navigationController ;
        vc.index = 0 ;
        vc.tagModel = self.sortTagArray[vc.index];
        [_pageVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    }
}
#pragma mark <UIPageViewControllerDelegate,UIPageViewControllerDataSource>
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    RankingListVC * currentVC = pageViewController.viewControllers[0];
    if (currentVC.index == 0)
    {
        return nil ;
    }else
    {
        RankingListVC * vc  = [[RankingListVC alloc]init];
        vc.navigationController = self.navigationController ;
        vc.index = currentVC.index-1 ;
        vc.tagModel = self.sortTagArray[vc.index];
        
        return vc;
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    RankingListVC * currentVC = pageViewController.viewControllers[0];
    if (currentVC.index == self.sortTagArray.count-1)
    {
        return nil ;
    }else
    {
        RankingListVC * vc  = [[RankingListVC alloc]init];
        vc.navigationController = self.navigationController ;
        vc.index = currentVC.index+1 ;
        vc.tagModel = self.sortTagArray[vc.index];
        
        return vc;
    }
    return nil;

}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    RankingListVC * currentVC = pageViewController.viewControllers[0];
    
    for (int i = 0; i < bottomView.subviews.count; i++) {
        UIButton *button = bottomView.subviews[i];
        [self buttonStyle:button];
    }
    UIButton *button = [bottomView viewWithTag:currentVC.index+1];
    [self buttonHighLightStyle:button];
}
#pragma mark-----------------------------自定义气泡
-(void)createTableView {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [window addSubview:_bgView];
    
    self.bgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    tapGesture.delegate = self;
    [self.bgView addGestureRecognizer:tapGesture];
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, 70, 130, 150)];
    self.bgImageView.userInteractionEnabled = YES;
    self.bgImageView.image = [UIImage imageNamed:@"x_cishu_ditu.png"];
    [self.bgView addSubview:self.bgImageView];
    
    self.sTitleArray = @[@"访问次数",@"点赞次数",@"时间"];
    self.smallTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.bgImageView.frame), CGRectGetHeight(self.bgImageView.frame)-5) style:UITableViewStylePlain];
    self.smallTableView.dataSource = self;
    self.smallTableView.delegate = self;
    [self.bgImageView addSubview:self.smallTableView];
    self.smallTableView.scrollEnabled = NO;
}
-(void)tapGestureAction:(UITapGestureRecognizer *)tap {
    CGPoint touchPoint = [tap locationInView:nil]; 
    CGPoint convertPoint = [self.bgImageView convertPoint:touchPoint fromView:tap.view];
    if (CGRectContainsPoint(self.view.bounds, convertPoint)) {
        return;
    }
    [self.bgView removeFromSuperview];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sTitleArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifer = @"identifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    if ([self.selectedIndexPath isEqual:indexPath]) {

        cell.accessoryView= [self returnButtonByIsSelected:YES];
    }else{
        cell.accessoryView= [self returnButtonByIsSelected:NO];
    }

    cell.textLabel.text = self.sTitleArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectedIndexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.accessoryView= [self returnButtonByIsSelected:NO];
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView= [self returnButtonByIsSelected:YES];
    
    self.selectedIndexPath = indexPath;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortType" object:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    [self.bgView removeFromSuperview];

}

- (void)btnClicked:(id)sender event:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.smallTableView];
    NSIndexPath *indexPath= [self.smallTableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {
        [self tableView: self.smallTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}
-(void)tableView:(UITableView*)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath{
    if (self.selectedIndexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.accessoryView= [self returnButtonByIsSelected:NO];
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView= [self returnButtonByIsSelected:YES];
    
    self.selectedIndexPath = indexPath;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortType" object:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    [self.bgView removeFromSuperview];

}
-(UIButton *)returnButtonByIsSelected:(BOOL)isSelected {
    UIImage *image;
    if (isSelected) {
        image= [UIImage imageNamed:@"sort_circleSelected"];
    }else {
        image= [UIImage imageNamed:@"sort_circle"];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, image.size.width/2, image.size.height/2);;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.backgroundColor= [UIColor clearColor];
    [button addTarget:self action:@selector(btnClicked:event:)  forControlEvents:UIControlEventTouchUpInside];
    return button;
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
