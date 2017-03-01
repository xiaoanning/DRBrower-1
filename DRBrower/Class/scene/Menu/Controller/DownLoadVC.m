//
//  DownLoadVC.m
//  DRBrower
//
//  Created by QiQi on 2017/2/28.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DownLoadVC.h"
#import "DownloadCell.h"
#import "DownloadModel.h"

static NSString *const downloadCellIdentifier = @"DownloadCell";

@interface DownLoadVC ()<UITableViewDelegate, UITableViewDataSource,SWTableViewCellDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,DownloadCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *downloadArray;


@end

@implementation DownLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;

    [self data];
    [self setupTableView];
    [self setupEmptyView];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)data {
    self.downloadArray = [DownloadModel selectDownloadWithState:NO fromRealm:REALM_DOWNLOAD];
    [self.tableView reloadData];

}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"DownloadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:downloadCellIdentifier];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.downloadArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:downloadCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.downlaodDelegate = self;
    cell.rightUtilityButtons = [self rightButtons];
//    [cell seell];
    DownloadModel *model = self.downloadArray[indexPath.row];
    [cell downloadCell:cell model:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO:暂停下载
}

- (void)downloadStateCompleted:(DownloadModel *)download {
    download.state = YES;
    [download updateStateFromRealm:REALM_DOWNLOAD];
    [self.downloadArray removeAllObjects];
    [self data];
    
}

#pragma mark - SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell
didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
//    DownloadModel *model = self.downloadArray[cellIndexPath.row];
//    [DownloadModel deleteOneRecord:model fromRealm:REALM_HISTORY];
    [self.downloadArray removeObjectAtIndex:(NSUInteger)index];
    [self.tableView deleteRowsAtIndexPaths:@[ cellIndexPath ]
                          withRowAnimation:UITableViewRowAnimationLeft];
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    // allow just one cell's utility button to be open at once
    return YES;
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor grayColor]
                                                title:@"删除"];
    return rightUtilityButtons;
}

#pragma mark - 空白页
- (void)setupEmptyView {
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.tableFooterView = [UIView new];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"还没有浏览记录哦！";
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName : paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
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
