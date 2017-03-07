//
//  HistoryVC.m
//  DRBrower
//
//  Created by QiQi on 2017/2/7.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "HistoryVC.h"
#import "MenuVC.h"
#import "SearchVC.h"
#import "RecordRootVC.h"

#import "RecordCell.h"

#import "RecordModel.h"

static NSString *const recordCellIdentifier = @"RecordCell";

@interface HistoryVC ()<SWTableViewCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *emptyBarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *historyArray;

@end

@implementation HistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"历史" image:nil tag:0];
    // Do any additional setup after loading the view.
    [self setupTableView];
    self.historyArray = [NSMutableArray arrayWithArray:[RecordModel realmSelectAllRecordFromRealm:REALM_HISTORY]];//[DRLocaldData achieveHistoryData]];
    [self setupEmptyView];

    if ([self.historyArray count] == 0) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.recordRootVC emptyInHistoryButtonClick:^{
        [RecordModel deleteAllRecordFromRealm:REALM_HISTORY];
        [self.historyArray removeAllObjects];
        [self.tableView reloadData];
        [Tools showView:@"清除成功"];
    }];
}

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"RecordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:recordCellIdentifier];
}

- (IBAction)backBarButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.menuVC dismissViewControllerAnimated:YES completion:nil];
    }];
}


#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.historyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:recordCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.rightUtilityButtons = [self rightButtons];
    RecordModel *model = self.historyArray[indexPath.row];
    [cell recordCell:cell model:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
    SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    searchVC.recordModel = self.historyArray[indexPath.row];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell
didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    RecordModel *model = self.historyArray[cellIndexPath.row];
//    [DRLocaldData deleteOneHistoryData:model];
    [RecordModel deleteOneRecord:model fromRealm:REALM_HISTORY];
    [self.historyArray removeObjectAtIndex:(NSUInteger)index];
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
