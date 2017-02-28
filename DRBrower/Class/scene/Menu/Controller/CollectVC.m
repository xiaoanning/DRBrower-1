//
//  CollectVC.m
//  DRBrower
//
//  Created by QiQi on 2017/2/8.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "CollectVC.h"
#import "SearchVC.h"
#import "RecordRootVC.h"
#import "RecordCell.h"
#import "RecordModel.h"

static NSString *const recordCellIdentifier = @"RecordCell";

@interface CollectVC ()<SWTableViewCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong)NSMutableArray *collectArray;

@end

@implementation CollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"收藏" image:nil tag:0];
    [self setupTableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.collectArray = [NSMutableArray arrayWithArray:[DRLocaldData achieveCollectData]];
    [self setupEmptyView];
    if ([self.collectArray count] == 0) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self.recordRootVC emptyInCollectButtonClick:^{
        [DRLocaldData deleteAllCollectData];
        [self.collectArray removeAllObjects];
        [self.tableView reloadData];
    }];
    
}

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"RecordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:recordCellIdentifier];
}

- (IBAction)backBarButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:DISMISS_VIEW object:nil];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.collectArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:recordCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.rightUtilityButtons = [self rightButtons];
    RecordModel *model = self.collectArray[indexPath.row];
    [cell recordCell:cell model:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
    SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    searchVC.recordModel = self.collectArray[indexPath.row];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell
didTriggerRightUtilityButtonWithIndex:(NSInteger)index {

    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    RecordModel *model = self.collectArray[cellIndexPath.row];
    [DRLocaldData deleteOneCollectData:model];
    [self.collectArray removeObjectAtIndex:(NSUInteger)index];
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
                                                title:@"取消收藏"];
    return rightUtilityButtons;
}

#pragma mark - Stretchable Sub View Controller View Source

- (UIScrollView *)stretchableSubViewInSubViewController:(id)subViewController
{
    return self.tableView;
}

#pragma mark - 空白页
- (void)setupEmptyView {
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.tableFooterView = [UIView new];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"还没有收藏记录哦！";
    
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
