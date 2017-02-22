//
//  RankingListVC.m
//  DRBrower
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "RankingListVC.h"
#import "RankingCell.h"
#import "SortModel.h"
#import "SortTagModel.h"
#import "NewsDetailVC.h"

#define UP_LOAD @"上拉"
#define DOWN_LOAD @"下拉"


@interface RankingListVC ()<UITableViewDelegate,UITableViewDataSource,RankingButtonDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *sortTagArray;
@property (nonatomic,strong) NSMutableArray *sortListArray;
@end

@implementation RankingListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.sortTagArray = [NSArray array];
    self.sortListArray = [NSMutableArray arrayWithCapacity:5];
    
    [self createTableView];
    
    [self getSortListByModel:self.tagModel type:DOWN_LOAD sort:self.sort];
    
    [self fooderRereshing];
    [self headerRereshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"sortType" object:nil];
}
- (void) tongzhi:(NSNotification *)notification{
    NSString *sortType = notification.object;
    [self getSortListByModel:self.tagModel type:DOWN_LOAD sort:sortType];
}
    
#pragma mark - 上下拉刷新
//下拉
- (void)headerRereshing {
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
}

//上拉
- (void)fooderRereshing {
    
    [self headerRereshing];
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer =
    [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadNewData {
    // 1.请求数据\2.刷新表格\3.拿到当前的下拉刷新控件，结束刷新状态
    
    [self getSortListByModel:self.tagModel type:DOWN_LOAD sort:self.sort];
    [self.tableView.mj_header endRefreshing];
    NSLog(@"下拉刷新");
}

- (void)loadMoreData {
    //1.请求数据\2.刷新表格\3.拿到当前的下拉刷新控件，结束刷新状态
    [self getSortListByModel:self.tagModel type:UP_LOAD sort:self.sort];
    [self.tableView.mj_footer endRefreshing];
    
    NSLog(@"上拉刷新");
}
//获取排行列表
- (void)getSortListByModel:(SortTagModel *)model type:(NSString *)type sort:(NSString *)sort{
    if (sort == nil || [sort integerValue] ==0) {
        sort = @"visit_num";
    }else if ([sort integerValue] ==1) {
        sort = @"love_num";
    }else if ([sort integerValue] ==2) {
        sort = @"updatetime";
    }
    NSString *site_type = model.site_type;
    [SortModel getSortListUrl:[NSString stringWithFormat:@"%@%@%@&sort=%@",BASE_URL,URL_GETSORTLIST,site_type,sort] parameters:@{} block:^(SortListModel *newsList, NSError *error) {
        if ([type isEqualToString:DOWN_LOAD]) {
            [self.sortListArray insertObjects:newsList.data
                                    atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [newsList.data count])]];

        }else {
            [self.sortListArray addObjectsFromArray:newsList.data];
        }
        [self.tableView reloadData];
    }];
}

-(void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"RankingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"rankingCell"];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sortListArray && self.sortListArray.count > 0) {
        return self.sortListArray.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rankingCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell rankingCell:cell model:self.sortListArray[indexPath.row] index:indexPath.row];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SortModel *sortModel = self.sortListArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NewsDetail" bundle:[NSBundle mainBundle]];
    NewsDetailVC *newsDetailVC = (NewsDetailVC *)[storyboard instantiateViewControllerWithIdentifier:@"NewsDetailVC"];
    newsDetailVC.sortModel = sortModel;
    [self.navigationController showViewController:newsDetailVC sender:nil];
}

#pragma mark-------------RankingButtonDelegate 代理方法
-(void)touchUpPraiseButtonActionWithIndex:(NSInteger)index {
    
}
-(void)touchUpInformButtonActionWithIndex:(NSInteger)index {
    
}
-(void)touchUpCommentButtonActionWithIndex:(NSInteger)index {
    
}
-(void)touchUpUserButtonActionWithIndex:(NSInteger)index {
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sortType" object:nil];
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
