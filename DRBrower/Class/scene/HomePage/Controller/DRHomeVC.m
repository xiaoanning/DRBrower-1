//
//  DRHomeVC.m
//  DRBrower
//
//  Created by QiQi on 2016/12/20.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "DRHomeVC.h"
#import "SearchVC.h"
#import "NewsDetailVC.h"
#import "WebsiteRootVC.h"

#import "NewsTagModel.h"
#import "NewsModel.h"
#import "WebsiteModel.h"

#import "ZeroPicCell.h"
#import "OnePicCell.h"
#import "ThreePicCell.h"

#import "HomeToolBar.h"

#import "NewsListViewController.h"
#import "RankingViewController.h"

static NSString *const onePicCellIdentifier = @"OnePicCell";
static NSString *const threePicCellIdentifier = @"ThreePicCell";
static NSString *const zeroPicCellIdentifier = @"ZeroPicCell";

#define UP_LOAD @"上拉"
#define DOWN_LOAD @"下拉"

@interface DRHomeVC ()<UIPageViewControllerDelegate , UIPageViewControllerDataSource>

@property (weak, nonatomic) IBOutlet HomeToolBar *homeToolBar;
@property (weak, nonatomic) IBOutlet TagsView *tagsView;
@property (strong, nonatomic) HomeTopView *top;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsViewHeightConstraint;

@property (strong, nonatomic) NSArray *tagListArray;
@property (strong, nonatomic) NSMutableArray *newsListArray;
@property (strong, nonatomic) NSMutableArray *websiteArray;

@property (strong, nonatomic) NewsTagModel *newsTag;
@property (assign, nonatomic) BOOL isHeight;

@property ( nonatomic , strong ) UIPageViewController * pageVC ;

@end

@implementation DRHomeVC

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    [self.homeTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view bringSubviewToFront:self.homeTableView];
    self.tagsView.delegate = self;
    self.homeToolBar.delegate = self;
    self.isHeight = YES;
    
    [self getTagData];
    [self getNewsByTag:nil type:nil];
    [self getWebsiteData];
    
    [self setupTableView];
    
    self.newsListArray = [NSMutableArray arrayWithCapacity:5];
    self.navigationController.navigationBarHidden = YES;
    [self fooderRereshing];
    [self headerRereshing];

    
    [self.homeTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    // Do any additional setup after loading the view.
}

- (void)setupTableView {
    self.homeTableView.bounces = NO;
    [self.homeTableView registerNib:[UINib nibWithNibName:@"OnePicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:onePicCellIdentifier];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ThreePicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:threePicCellIdentifier];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ZeroPicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:zeroPicCellIdentifier];

}
#pragma mark - UIPageViewController
-(void)createPageVCUI
{
    
    CGFloat topSpace = 52.0f ;
    
    _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageVC.delegate = self ;
    _pageVC.dataSource = self ;
    _pageVC.view.frame = CGRectMake(0, topSpace, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - topSpace);
    
    [self.view addSubview:_pageVC.view];
    [self.view bringSubviewToFront:_pageVC.view];
    self.homeTableView.hidden = YES ;
    
    NewsListViewController * vc = [[NewsListViewController alloc]init] ;
    vc.navigationController = self.navigationController ;
    vc.index = 0 ;
    NSLog(@"index====%ld",(long)vc.index);
    vc.model = self.tagListArray[vc.index];
    
    [_pageVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
    }];
    
    [self.tagsView changeButtonWhenPageViewScroll:[self.tagsView.tagsSV viewWithTag:1+vc.index]  withRefresh:NO];
    
        
}

#pragma mark <UIPageViewControllerDelegate,UIPageViewControllerDataSource>
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NewsListViewController * currentVC = pageViewController.viewControllers[0];
    if (currentVC.index == 0)
    {
        return nil ;
    }else
    {
        NewsListViewController * vc  = [[NewsListViewController alloc]init];
        vc.navigationController = self.navigationController ;
        vc.index = currentVC.index-1 ;
        vc.model = self.tagListArray[vc.index];
        
        return vc;
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NewsListViewController * currentVC = pageViewController.viewControllers[0];
    if (currentVC.index == self.tagListArray.count-1)
    {
        return nil ;
    }else
    {
        NewsListViewController * vc  = [[NewsListViewController alloc]init];
        vc.navigationController = self.navigationController ;
        vc.index = currentVC.index+1 ;
        vc.model = self.tagListArray[vc.index];
        
        return vc;
    }
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NewsListViewController * currentVC = pageViewController.viewControllers[0];
    
    [self.tagsView changeButtonWhenPageViewScroll:[self.tagsView.tagsSV viewWithTag:1 + currentVC.index]  withRefresh:NO];
    
}


#pragma mark - 数据请求
//请求新闻分类标签
- (void)getTagData {
    [NewsTagModel getNewsTagUrl:[NSString stringWithFormat:@"%@%@",BASE_URL,URL_GETTABS]
                     parameters:@{}
                          block:^(NewsTagListModel *tagList, NSError *error) {
                              self.tagListArray = tagList.data;
                              [self.tagsView createSubViewsByTagArray:self.tagListArray];
                          }];
}

//获取新闻
- (void)getNewsByTag:(NewsTagModel *)tag type:(NSString *)type {
    NSString *tagId = tag.tagId;
    if (tag == nil) {
        tagId = TAG_ID_RECOMMEND;
    }
    [NewsModel getNewsByTagUrl:[NSString stringWithFormat:@"%@%@%@",BASE_URL,URL_GETNEWS_CID,tagId]
                    parameters:@{}
                         block:^(NewsListModel *newsList, NSError *error) {
                        
                            if ([type isEqualToString:DOWN_LOAD]) {
                                [self.newsListArray insertObjects:newsList.data
                                                        atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [newsList.data count])]];
                            }else {
                                [self.newsListArray addObjectsFromArray:newsList.data];
                            }
                            
                            [self.homeTableView reloadData];
                    }];
}

//获取网站
- (void)getWebsiteData {
    [WebsiteModel getWebsiteUrl:[NSString stringWithFormat:@"%@%@",BASE_URL,URL_GETWEBSITE]
                     parameters:@{}
                          block:^(WebsiteListModel *websiteList, NSError *error) {

                              self.websiteArray = websiteList.data;
                              
                              if ([DRLocaldData achieveWebsiteData] == nil) {
                                 
                                  NSMutableArray *array = [NSMutableArray arrayWithArray:websiteList.data];
                                  [array removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(9, [array count]-9)]];
                                  
                                  WebsiteModel *addWebsite = [[WebsiteModel alloc] init];
                                  addWebsite.name = NSLocalizedString(@"添加", nil);
                                  addWebsite.icon = @"add";
                                  [array addObject:addWebsite];
                                  
                                  [DRLocaldData saveWebsiteData:array];
                                  NSLog(@"%@",array);
                              }
                          }];
    
}

#pragma mark - 上下拉刷新
//下拉
- (void)headerRereshing {
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.homeTableView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
}

//上拉
- (void)fooderRereshing {
    
    [self headerRereshing];
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.homeTableView.mj_footer =
    [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadNewData {
    // 1.请求数据\2.刷新表格\3.拿到当前的下拉刷新控件，结束刷新状态

    [self getNewsByTag:self.newsTag type:DOWN_LOAD];
    [self.homeTableView.mj_header endRefreshing];
    NSLog(@"下拉刷新");
}

- (void)loadMoreData {
    //1.请求数据\2.刷新表格\3.拿到当前的下拉刷新控件，结束刷新状态
    [self getNewsByTag:self.newsTag type:UP_LOAD];
    [self.homeTableView.mj_footer endRefreshing];

    NSLog(@"上拉刷新");
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.newsListArray) {
        return self.newsListArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *news = self.newsListArray[indexPath.row];
    
    switch ([news.imgs count]) {
        case 0:
            return 100;
            break;
        case 1:{
            return 100;
        }
            break;
        case 3:{
            return 180;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NewsModel *news = self.newsListArray[indexPath.row];
    
    switch ([news.imgs count]) {
        case 0:{
            ZeroPicCell *cell = [tableView dequeueReusableCellWithIdentifier:zeroPicCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell zeroPicCell:cell model:news];
            return cell;
        }
            break;
        case 1:{
            OnePicCell *cell = [tableView dequeueReusableCellWithIdentifier:onePicCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell onePicCell:cell model:news];
            return cell;
        }
            break;
        case 3:{
            ThreePicCell *cell = [tableView dequeueReusableCellWithIdentifier:threePicCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell threePicCell:cell model:news];
            return cell;
        }
            break;
            
        default:
            break;
    }
    

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *news = self.newsListArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NewsDetail" bundle:[NSBundle mainBundle]];
    NewsDetailVC *newsDetailVC = (NewsDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"NewsDetailVC"];
    newsDetailVC.newsModel = news;
    [self.navigationController showViewController:newsDetailVC sender:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (self.isHeight == YES) {
        
        if ([Tools isRemainder:[DRLocaldData achieveWebsiteData]] == YES) {

            return 435;

        }else {
            return 435-37;
        }
    }
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.isHeight == YES) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"HomeTopView" owner:nil options:nil];
        self.top = [views lastObject];
        self.top.delegate = self;
        return self.top;
    }
    return nil;

    
}

#pragma mark - custom delegate
//排行
-(void)touchUpSortButtonAction {
    RankingViewController *rankingVC = [[RankingViewController alloc] init];
    [self.navigationController pushViewController:rankingVC animated:YES];
}

//频道
- (void)touchUpChannelButtonAction:(NSInteger)buttonTags {
    [self.newsListArray removeAllObjects];
    NewsTagModel *newstag = self.tagListArray[buttonTags];
    
    UIPageViewControllerNavigationDirection direction ;
    if ([self.tagListArray indexOfObject:newstag] == [self.tagListArray indexOfObject:self.newsTag] )
    {
        return ;
    }else if ([self.tagListArray indexOfObject:newstag] > [self.tagListArray indexOfObject:self.newsTag])
    {
        direction = UIPageViewControllerNavigationDirectionForward ;
    }else
    {
        direction = UIPageViewControllerNavigationDirectionReverse ;
    }
    
    NewsListViewController * vc = [[NewsListViewController alloc]init] ;
    vc.index = buttonTags ;
    vc.model = self.tagListArray[vc.index];
    
    [_pageVC setViewControllers:@[vc] direction:direction animated:YES completion:nil];
    
    self.newsTag = newstag;
}



//homeToolBar

- (void)touchUpHomeButtonAction {
    _pageVC = nil;
    self.pageVC.view.hidden = YES ;
    [self.pageVC.view removeFromSuperview];
    self.homeTableView.hidden = NO ;
    [self.view bringSubviewToFront:self.homeTableView];
    
    self.listTopConstraint.constant = 0;
    self.isHeight = YES;
    self.homeTableView.bounces = NO;
    self.homeTableView.contentOffset =  CGPointMake(0, 0);
    [self.homeTableView reloadData];
}

- (void)touchUpMenuButtonAction {
    //TODO:login menu
}

//搜索
- (void)touchUpSearchButtonAction {
    // 1.创建热门搜索
//    NSArray *hotSeaches = nil;
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:@"搜索或输入网址" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
        SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
        
        [searchViewController.navigationController pushViewController:searchVC animated:YES];
    }];
    // 3. 设置风格
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
//    searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}

//website collection 点击事件
- (void)websiteViewSelectWithWebsite:(WebsiteModel *)website {
    
    if (website.icon&&website.url) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
        SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
        searchVC.searchText = website.url;

        [self.navigationController pushViewController:searchVC animated:YES];
        NSLog(@"我被点击了 %@",website.name);

    }else if([website.icon isEqualToString:@"add"]){
        
        WebsiteRootVC *websiteRootVC = [[WebsiteRootVC alloc] init];
        websiteRootVC.websiteArray = self.websiteArray;
        [self.navigationController showViewController:websiteRootVC sender:nil];
        
        NSLog(@"添加网页");

    }
}

//弹窗 
- (void)homeTopViewpresentView:(WebsiteModel *)model {
    
    
    if (model.name && model.url) {
        
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定要删除 %@ 吗？",model.name]
                                            message:nil
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction =
        [UIAlertAction actionWithTitle:@"取消"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   
                               }];
        
        UIAlertAction *confirmAction =
        [UIAlertAction actionWithTitle:@"确定"
                                 style:UIAlertActionStyleDestructive
                               handler:^(UIAlertAction * _Nonnull action) {
                                   NSMutableArray *array = [DRLocaldData achieveWebsiteData];
                                   if ([array containsObject:model]) {
                                       [array removeObject:model];
                                       [DRLocaldData saveWebsiteData:array];
                                       [self.homeTableView reloadData];
                                   }
                                   
                               }];
        
        [alert addAction:confirmAction];
        [alert addAction:cancelAction];

        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        
        if (offset.y > 410) {
            NSLog(@"%@",NSStringFromCGPoint(offset));
            
            self.isHeight = NO;
            self.listTopConstraint.constant = 52;
            self.homeTableView.bounces = YES;
            [self.homeTableView reloadData];
            
            if (_pageVC == nil) {
                [self createPageVCUI];
            }

        }
        
    }

    
}

#pragma mark - search
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText {
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
//            // 显示建议搜索结果
//            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
//            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
//                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
//                [searchSuggestionsM addObject:searchSuggestion];
//            }
//            // 返回
//            searchViewController.searchSuggestions = searchSuggestionsM;
//        });
    }
}

- (void)searchViewController:(PYSearchViewController *)searchViewController didSearchWithsearchBar:(UISearchBar *)searchBar searchText:(NSString *)searchText {
    NSLog(@"%@",searchText);
    if (searchText.length) { // 与搜索条件再搜索
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
        SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
        searchVC.searchText = searchText;
        searchVC.searchViewController = searchViewController;
        [searchViewController.navigationController pushViewController:searchVC animated:YES];
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
