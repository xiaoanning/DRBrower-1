//
//  WebsiteRecommendVC.m
//  DRBrower
//
//  Created by QiQi on 2017/1/9.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "WebsiteRecommendVC.h"
#import "WebsiteRecommendCell.h"

static NSString *const websiteRecommendCellIdentifier = @"WebsiteRecommendCell";

@interface WebsiteRecommendVC ()

@property (weak, nonatomic) IBOutlet UITableView *websiteTableView;

@end

@implementation WebsiteRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:nil tag:0];

    [self setupTableView];
    // Do any additional setup after loading the view.
}

- (void)setupTableView {
    self.websiteTableView.delegate = self;
    self.websiteTableView.dataSource = self;
    [self.websiteTableView registerNib:[UINib nibWithNibName:@"WebsiteRecommendCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:websiteRecommendCellIdentifier];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.websiteArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WebsiteRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:websiteRecommendCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WebsiteModel *website = self.websiteArray[indexPath.row];
    [cell websiteRecommendCell:cell model:website];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WebsiteModel *website = self.websiteArray[indexPath.row];
    NSMutableArray *array = [DRLocaldData achieveWebsiteData];
    
    if ([array containsObject:website] == NO) {
        
        [array insertObject:website atIndex:array.count-1];
        [DRLocaldData saveWebsiteData:array];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Stretchable Sub View Controller View Source

- (UIScrollView *)stretchableSubViewInSubViewController:(id)subViewController
{
    return self.websiteTableView;
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
