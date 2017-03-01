//
//  SortRootVC.m
//  DRBrower
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "SortRootVC.h"
#import "SortTagModel.h"

#import "SortVideoVC.h"
#import "SortNewFilmVC.h"
#import "SortOtherVC.h"

@interface SortRootVC ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSArray *sortTagArray;

@property (nonatomic,strong) UITableView *smallTableView;
@property (nonatomic,strong) NSArray *sTitleArray;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@end

@implementation SortRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.sortTagArray = [NSArray array];
    
    [self getSortTag];
//    [self loadViewControllers];
    
    [self creaetRightButtonItem];
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.title = NSLocalizedString(@"热度排行", nil);
    
    
}
-(void)loadViewControllers {
    
//    SortVideoVC *sortVideoVC = [[SortVideoVC alloc] init];
//    sortVideoVC.sortRootVC = self;
//    SortNewFilmVC *sortNewFilmVC = [[SortNewFilmVC alloc] init];
//    sortNewFilmVC.sortRootVC = self;
//    SortOtherVC *sortOtherVC = [[SortOtherVC alloc] init];
//    sortOtherVC.sortRootVC = self;
//    
//    NSArray *viewControllersArray = @[sortVideoVC,sortNewFilmVC,sortOtherVC];
//    self.viewControllers = viewControllersArray;

}
//获取排行分类标签
-(void)getSortTag {
    [SortTagModel getSortTagUrl:[NSString stringWithFormat:@"%@%@",BASE_URL,URL_GETSORTTAG] parameters:@{} block:^(SortTagListModel *newsList, NSError *error) {
        
        self.sortTagArray = newsList.data;
        
        SortVideoVC *sortVideoVC = [[SortVideoVC alloc] init];
        sortVideoVC.sortRootVC = self;
        sortVideoVC.sortTagModel = self.sortTagArray[0];
        
        SortNewFilmVC *sortNewFilmVC = [[SortNewFilmVC alloc] init];
        sortNewFilmVC.sortRootVC = self;
        sortNewFilmVC.sortTagModel = self.sortTagArray[1];
        
        SortOtherVC *sortOtherVC = [[SortOtherVC alloc] init];
        sortOtherVC.sortRootVC = self;
        sortOtherVC.sortTagModel = self.sortTagArray[2];
        
        NSArray *viewControllersArray = @[sortVideoVC,sortNewFilmVC,sortOtherVC];
        self.viewControllers = viewControllersArray;
        

    }];
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

- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
