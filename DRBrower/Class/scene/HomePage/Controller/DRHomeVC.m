//
//  DRHomeVC.m
//  DRBrower
//
//  Created by QiQi on 2016/12/20.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "DRHomeVC.h"
#import "NewsTagModel.h"
#import "NewsModel.h"
#import "ZeroPicCell.h"
#import "OnePicCell.h"
#import "ThreePicCell.h"
#import "NewsDetailVC.h"
#import "HomeToolBar.h"

static NSString *const onePicCellIdentifier = @"OnePicCell";
static NSString *const threePicCellIdentifier = @"ThreePicCell";
static NSString *const zeroPicCellIdentifier = @"ZeroPicCell";

#define UP_LOAD @"上拉"
#define DOWN_LOAD @"下拉"

@interface DRHomeVC ()

@property (weak, nonatomic) IBOutlet HomeToolBar *homeToolBar;
@property (weak, nonatomic) IBOutlet TagsView *tagsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsViewHeightConstraint;
@property (strong, nonatomic) NSArray *tagListArray;
@property (strong, nonatomic) NSMutableArray *newsListArray;
@property (strong, nonatomic) UIPanGestureRecognizer *panGP;
@property (strong, nonatomic) NewsTagModel *newsTag;

@end

@implementation DRHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPanGP];
    [self.view bringSubviewToFront:self.homeTableView];
    self.tagsViewHeightConstraint.constant = 0;
    self.tagsView.delegate = self;
    self.homeToolBar.delegate = self;
    [self getTagdata];
    [self getNewsByTag:nil type:nil];
    [self setupTableView];
    
    self.newsListArray = [NSMutableArray arrayWithCapacity:5];
    self.navigationController.navigationBarHidden = YES;
    
    [self headerRereshing];
    [self fooderRereshing];
    // Do any additional setup after loading the view.
}

- (void)setupPanGP {
    self.panGP = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:self.panGP];
}

- (void)setupTableView {
    self.homeTableView.scrollEnabled = NO;
    [self.homeTableView registerNib:[UINib nibWithNibName:@"OnePicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:onePicCellIdentifier];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ThreePicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:threePicCellIdentifier];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ZeroPicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:zeroPicCellIdentifier];

}

///请求新闻分类标签
- (void)getTagdata {
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
                            }else if ([type isEqualToString:UP_LOAD]) {
                                [self.newsListArray insertObjects:newsList.data
                                                        atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self.newsListArray count], [newsList.data count])]];
                            }else {
                                [self.newsListArray addObjectsFromArray:newsList.data];
                            }
                            
                            [self.homeTableView reloadData];
                    }];
}

///平移手势的回调方法
- (void)panAction:(UIPanGestureRecognizer*)gesture{
    //得到当前手势所在视图
    //得到我们在视图上移动的偏移量
    CGPoint currentPoint = [gesture translationInView:self.homeTableView.superview];
    //通过2D仿射变换函数中与位移有关的函数实现视图位置变化
    
//    self.homeView.transform = CGAffineTransformTranslate(self.homeView.transform, 0, currentPoint.y);
    NSLog(@"%f",currentPoint.y);
    
    if (currentPoint.y <0&&self.listTopConstraint.constant > 52&&self.listTopConstraint.constant <= 465) {
        self.listTopConstraint.constant = self.listTopConstraint.constant-7;
        self.topView.alpha = self.topView.alpha-0.01;
    }
    if (currentPoint.y >0&&self.listTopConstraint.constant <465) {
        self.listTopConstraint.constant = self.listTopConstraint.constant+7;
        self.topView.alpha = self.topView.alpha+0.01;
    }
    if (self.listTopConstraint.constant == 52 || self.listTopConstraint.constant < 100) {
        [self showList];
        
    }
    
    NSLog(@"%f",self.listTopConstraint.constant);
    //复原 每次都是从00点开始
    [gesture setTranslation:CGPointZero inView:self.homeTableView.superview];
}

- (void)showList {
    self.tagsViewHeightConstraint.constant = 52;
    self.listTopConstraint.constant = 52;
    self.homeTableView.scrollEnabled = YES;
    [self.view removeGestureRecognizer:self.panGP];
}

- (void)showTopView {
    self.tagsViewHeightConstraint.constant = 0;
    self.listTopConstraint.constant = 465;
    self.homeTableView.scrollEnabled = NO;
    self.topView.alpha = 1;
    [self setupPanGP];
}

#pragma mark - 上下拉刷新
- (void)headerRereshing {
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.homeTableView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
}

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
    return self.newsListArray.count;
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
    
    [self showList];
    NewsModel *news = self.newsListArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NewsDetail" bundle:[NSBundle mainBundle]];
    NewsDetailVC *newsDetailVC = (NewsDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"NewsDetailVC"];
    newsDetailVC.newsModel = news;
    [self.navigationController showViewController:newsDetailVC sender:nil];
}

#pragma mark - custom delegate
- (void)touchUpChannelButtonAction:(NSInteger)buttonTags {
    [self.newsListArray removeAllObjects];
    NewsTagModel *newstag = self.tagListArray[buttonTags];
    [self getNewsByTag:newstag type:nil];
    self.newsTag = newstag;
}

- (void)touchUpHomeButtonAction {
    [self showTopView];
}

- (void)touchUpMenuButtonAction {
    //TODO:longin menu
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
