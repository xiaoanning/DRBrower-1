//
//  NewsListViewController.m
//  DRBrower
//
//  Created by apple on 17/2/17.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "NewsListViewController.h"

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

static NSString *const onePicCellIdentifier = @"OnePicCell";
static NSString *const threePicCellIdentifier = @"ThreePicCell";
static NSString *const zeroPicCellIdentifier = @"ZeroPicCell";

#define UP_LOAD @"上拉"
#define DOWN_LOAD @"下拉"

@interface NewsListViewController ()


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

@implementation NewsListViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.newsListArray = [NSMutableArray array];
    
    self.homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.homeTableView.delegate = self ;
    self.homeTableView.dataSource = self ;
    [self.view addSubview:self.homeTableView];
    
    [self.view bringSubviewToFront:self.homeTableView];
    
    [self setupTableView];
    
    self.navigationController.navigationBarHidden = YES;
    [self fooderRereshing];
    [self headerRereshing];
    
    [self getNewsByTag:_model type:DOWN_LOAD];
    
    
}

- (void)setupTableView {
    self.homeTableView.bounces = YES;
    [self.homeTableView registerNib:[UINib nibWithNibName:@"OnePicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:onePicCellIdentifier];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ThreePicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:threePicCellIdentifier];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ZeroPicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:zeroPicCellIdentifier];
    
}


#pragma mark - 数据请求

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


#pragma mark - 上下拉刷新
//下拉
- (void)headerRereshing {
//
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
    
    if (self.newsListArray)
    {
        return self.newsListArray.count;
    }
    
    return 0 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *news = self.newsListArray[indexPath.row];
    
    switch ([news.imgs count]) {
        case 0:
            return 80;
            break;
        case 1:{
            return 100;
        }
            break;
        case 3:{
            return 160;
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
    
//    NewsModel *news = self.newsListArray[indexPath.row];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NewsDetail" bundle:[NSBundle mainBundle]];
//    NewsDetailVC *newsDetailVC = (NewsDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"NewsDetailVC"];
//    newsDetailVC.newsModel = news;
//    [_navigationController showViewController:newsDetailVC sender:nil];
    
    NewsModel *newsModel = self.newsListArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
    SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    searchVC.newsModel = newsModel;
    [self.navigationController pushViewController:searchVC animated:YES];

}



@end
