//
//  DRHomeVC.m
//  DRBrower
//
//  Created by QiQi on 2016/12/20.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "DRHomeVC.h"
#import "SearchVC.h"
#import "WebsiteRootVC.h"
#import "MenuVC.h"
#import "ShareVC.h"
#import "RecordRootVC.h"
#import "NewsListViewController.h"
#import "MoreVC.h"
#import "GenderVC.h"

#import "NewsTagModel.h"
#import "NewsModel.h"
#import "WebsiteModel.h"
#import "ShareModel.h"
#import "WeatherModel.h"

#import "ZeroPicCell.h"
#import "OnePicCell.h"
#import "ThreePicCell.h"
#import "MoreNewsCell.h"
#import "HomeToolBar.h"

#import "NewsListViewController.h"
#import "SortRootVC.h"

#import "AdviceVC.h"
#import "LoginVC.h"
#import "LoginModel.h"
#import "NewsPageVC.h"

static NSString *const onePicCellIdentifier = @"OnePicCell";
static NSString *const threePicCellIdentifier = @"ThreePicCell";
static NSString *const zeroPicCellIdentifier = @"ZeroPicCell";
static NSString *const moreNewsCellIdentifier = @"MoreNewsCell";

#define UP_LOAD @"上拉"
#define DOWN_LOAD @"下拉"

@interface DRHomeVC ()<MenuVCDelegate, QRCodeReaderDelegate, CLLocationManagerDelegate, NewsMenuDelegate>

@property (weak, nonatomic) IBOutlet HomeToolBar *homeToolBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsViewHeightConstraint;

@property (strong, nonatomic) NSArray *tagListArray;
@property (strong, nonatomic) NSArray *newsListArray;
@property (strong, nonatomic) NSMutableArray *websiteArray;

@property (strong, nonatomic) NewsTagModel *newsTag;
@property (strong, nonatomic) WeatherModel *weather;

@property (nonatomic, strong) DRLocationManager *locationManger;
@property (nonatomic,assign) BOOL loginSuccess;

@end

@implementation DRHomeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.homeTableView reloadData];
    [self userGenderVC];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    [self.view bringSubviewToFront:self.homeTableView];
    self.homeToolBar.delegate = self;
    [self.homeToolBar setBarButton:HomeToolBarRootVCTypeHome];
    self.navigationController.navigationBarHidden = YES;

    [self getNews];
    [self getWebsiteData];
    [self location];
    [self setupTableView];
    [self location];
}

- (void)setupTableView {
    [self.homeTableView registerNib:[UINib nibWithNibName:@"OnePicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:onePicCellIdentifier];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ThreePicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:threePicCellIdentifier];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"ZeroPicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:zeroPicCellIdentifier];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"MoreNewsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:moreNewsCellIdentifier];
}

- (void)location {
    self.locationManger = [[DRLocationManager alloc] init];
    self.locationManger.delegate = self;
    [self.locationManger creatManager];
    
}

- (void)userGenderVC {
    if ([UserInfo getUserGender]==nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        GenderVC *genderVC = (GenderVC *)[storyboard instantiateViewControllerWithIdentifier:@"GenderVC"];
        MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:genderVC];
        formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideFromTop;
        formSheetController.presentationController.portraitTopInset = self.view.center.y - 100;
        formSheetController.presentationController.contentViewSize = CGSizeMake(SCREEN_WIDTH - 40, 200);
        [self presentViewController:formSheetController animated:YES completion:nil];
    }
}

#pragma mark - 数据请求
//获取新闻
- (void)getNews {
    [NewsModel getNewsByTagUrl:[NSString stringWithFormat:@"%@%@%@",BASE_URL,URL_GETNEWS_CID,TAG_ID_RECOMMEND]
                    parameters:@{}
                         block:^(NewsListModel *newsList, NSError *error) {
                             if (!error) {
                                 self.newsListArray = [newsList.data subarrayWithRange:NSMakeRange(0, 5)];
                                 [self.homeTableView reloadData];
                             }
                             
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
                                  if ([array count]>9) {
                                      [array removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(9, [array count]-9)]];
                                  }
                                  
                                  
                                  WebsiteModel *addWebsite = [[WebsiteModel alloc] init];
                                  addWebsite.name = NSLocalizedString(@"添加", nil);
                                  addWebsite.icon = @"add";
                                  [array addObject:addWebsite];
                                  
                                  [DRLocaldData saveWebsiteData:array];
                              }
                          }];
    
}

- (void)getWeatherData:(NSString *)city {
    
    [WeatherModel getWeatherUrl:URL_GETWEATHER
                     parameters:city
                          block:^(WeatherModel *weather, NSError *error) {
                              if (!error) {
                                  self.weather = weather;
                                  [self.homeTableView reloadData];
                              }
                          }];
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.newsListArray.count;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *news = self.newsListArray[indexPath.row];
    if (indexPath.section == 0) {
        switch ([news.imgs count]) {
            case 0:
                return 70;
                break;
            case 1:{
                return 100;
            }
                break;
            case 3:{
                return 145;
            }
                break;
                
            default:
                break;
        }
    }
        return 45;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NewsModel *news = self.newsListArray[indexPath.row];
    if (indexPath.section == 0) {
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
    }else {
        MoreNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:moreNewsCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NewsModel *news = self.newsListArray[indexPath.row];
        
        news.isSelected = YES;
        [self.homeTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
        SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
        searchVC.newsModel = news;
        [self.navigationController showViewController:searchVC sender:nil];
    }else {
        //TODO: 新闻页
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NewsPage" bundle:[NSBundle mainBundle]];
        NewsPageVC *newsPageVC = (NewsPageVC *)[storyboard instantiateViewControllerWithIdentifier:@"NewsPageVC"];
        newsPageVC.tagListArray = self.tagListArray;
        newsPageVC.delegate = self;
        [self.navigationController showViewController:newsPageVC sender:nil];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [Tools headHeight:[DRLocaldData achieveWebsiteData]];
    }else {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"HomeTopView" owner:nil options:nil];
        HomeTopView *top = [views lastObject];
        top.delegate = self;
        [top weatherHeader:top model:self.weather];
        return top;
    }
    return nil;
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 50);
//    [button setTitle:@"点击查看更多" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(toucuUpMoreButton:) forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}
//-(void)toucuUpMoreButton:(UIButton *)button {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NewsPage" bundle:[NSBundle mainBundle]];
//    NewsPageVC *newsPageVC = (NewsPageVC *)[storyboard instantiateViewControllerWithIdentifier:@"NewsPageVC"];
//    newsPageVC.tagListArray = self.tagListArray;
//    newsPageVC.delegate = self;
//    [self.navigationController pushViewController:newsPageVC animated:YES];
//}
#pragma mark - custom delegate
#pragma mark - homeToolBar
//主页按钮
- (void)touchUpHomeButtonAction {
    self.homeTableView.hidden = NO ;
    [self.view bringSubviewToFront:self.homeTableView];
    
    self.listTopConstraint.constant = 0;
    self.homeTableView.bounces = NO;
    self.homeTableView.contentOffset =  CGPointMake(0, 0);
    [self.homeTableView reloadData];
    
}

//菜单按钮
- (void)touchUpMenuButtonAction {
    //菜单
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Menu" bundle:[NSBundle mainBundle]];
    MenuVC *menuVC = (MenuVC *)[storyboard instantiateViewControllerWithIdentifier:@"MenuVC"];
    menuVC.rootVCType = MenuVCRootVCTypeHome;
    MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:menuVC];
    formSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    formSheetController.presentationController.portraitTopInset = [UIScreen mainScreen].bounds.size.height - MENU_HEIGHT - 20;
    formSheetController.presentationController.contentViewSize = [UIScreen mainScreen].bounds.size;
    formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideAndBounceFromBottom;
    menuVC.delegate = self;
    [self presentViewController:formSheetController animated:YES completion:nil];
}

//share
- (void)touchUpPageButtonAction {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
    ShareVC *shareVC = (ShareVC *)[storyboard instantiateViewControllerWithIdentifier:@"ShareVC"];
    MZFormSheetPresentationViewController *shareFormSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:shareVC];
    shareFormSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    
    shareFormSheetController.presentationController.portraitTopInset = [UIScreen mainScreen].bounds.size.height - 240;
    shareFormSheetController.presentationController.contentViewSize = [UIScreen mainScreen].bounds.size;
    shareFormSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideAndBounceFromBottom;
    
    [self presentViewController:shareFormSheetController animated:YES completion:nil];
}

#pragma mark - manu
//history and collect
- (void)touchUpRecordButtonAction {
    RecordRootVC *recordRootVC = [[RecordRootVC alloc] init];
    [self.navigationController showViewController:recordRootVC sender:nil];
}

//setting
- (void)touchUpMoreButtonAction {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"More" bundle:[NSBundle mainBundle]];
    MoreVC *moreVC = (MoreVC *)[storyboard instantiateViewControllerWithIdentifier:@"MoreVC"];
    [self.navigationController showViewController:moreVC sender:nil];
}

//吐槽
-(void)touchUpSpitButtonAction {
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Advice" bundle:[NSBundle mainBundle]];
    AdviceVC *adviceVC = (AdviceVC *)[stroyboard instantiateViewControllerWithIdentifier:@"AdviceVC"];
    [self.navigationController showViewController:adviceVC sender:nil];
}

//客服群
-(void)touchUpServiceButtonAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"是否添加客服群:299032484"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Tools joinGroup:nil key:@"299032484"];
    }];;
    [alertController addAction:OKAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//登陆
-(void)touchUpIconImageView {
    if ([TOKEN isEqualToString:@"brower*@forapi@*"]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
        LoginVC *loginVC = (LoginVC *)[stroyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else {
        [self cancleLoginAlert];
    }
}

-(void)cancleLoginAlert {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否退出当前账户？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancleLogin];
    }];
    [alertVC addAction:OKAction];
    [alertVC addAction:cancleAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

//退出登陆
-(void)cancleLogin {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&dev_id=%@&uid=%@",PHP_BASE_URL,URL_LOGOUT,TOKEN,DEV_ID,[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_UID]];
    [LoginModel cancleLoginUrl:urlString parameters:@{} block:^(NSDictionary *dic, NSError *error) {
        NSLog(@"%@",dic);
        [Tools showView:dic[@"msg"]];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGIN_TOKEN];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGIN_UID];
    }];
}

#pragma mark - head
- (void)touchUpQRcodeButtonAction {
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    reader.modalPresentationStyle = UIModalPresentationFormSheet;
    reader.delegate = self;
    
    __weak typeof (self) wSelf = self;
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        [wSelf.navigationController popViewControllerAnimated:YES];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
        SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
        searchVC.searchText = resultAsString;
        
        [self.navigationController pushViewController:searchVC animated:YES];
    }];
    
    [self.navigationController pushViewController:reader animated:YES];
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

//website delete 弹窗
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


#pragma mark - search delegate
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

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
        SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
        searchVC.searchText = result;
        
        [self.navigationController pushViewController:searchVC animated:YES];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - location delegate
// 当定位到用户位置时调用
// 调用非常频繁(耗电)
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 一个CLLocation对象代表一个位置
    NSLog(@"%@",locations);
    
    __block DRGeocoder *geo = [[DRGeocoder alloc] init];
    [geo creatGeocoder:locations.lastObject
                 block:^(DRGeocoder *geocoder, NSError *error) {
                     
                     [self getWeatherData:[geocoder.city stringByAppendingString:geocoder.subLocality]];
                     
                     [manager stopUpdatingLocation];
                     
                     [[NSUserDefaults standardUserDefaults] setObject:@{@"city":geocoder.city,@"subLocality":geocoder.subLocality} forKey:GET_LOCATION];
                 }];
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
