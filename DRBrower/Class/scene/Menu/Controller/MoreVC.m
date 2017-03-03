//
//  MoreVC.m
//  DRBrower
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "MoreVC.h"
#import "BrightnessVC.h"
#import "SearchVC.h"

@interface MoreVC ()
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UILabel *cacheLabel;
@property (nonatomic,strong) NSMutableArray *switchStatusArray;
@end

@implementation MoreVC
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"更多";
    self.switchStatusArray = [NSMutableArray array];
    self.titleArray = @[@"广告屏蔽",@"只在WIFI模式下载",@"搜索引擎",@"账户管理",@"清理缓存",@"无图模式",@"无痕浏览",@"字体大小",@"二维码",@"绑定手机",@"调整亮度",@"官网"];
    
    self.moreTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"identifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titleArray[indexPath.row];
    if (indexPath.row == 4) {
        [self createLabelOnCell:cell];
    }
    if ([@[@"0",@"1",@"5",@"6"] containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
        [self createSwitchOnCell:cell index:indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 1:
            break;
        case 4:
            [self cleanCacheAlert];
            break;
        case 10:
            [self createBrightnessView];
            break;
        case 11:
            [self openWithUrl:@"http://www.drliulanqi.com/dr/index.html"];
            break;
        default:
            break;
    }
}
//创建右侧Label
-(void)createLabelOnCell:(UITableViewCell *)cell {
    self.cacheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.cacheLabel.textAlignment = NSTextAlignmentRight;
    self.cacheLabel.font = [UIFont boldSystemFontOfSize:15];
    self.cacheLabel.adjustsFontSizeToFitWidth = YES;
    self.cacheLabel.text = [NSString stringWithFormat:@"%.2f M",[self getCacheSize]];
    [cell addSubview:self.cacheLabel];
    [self.cacheLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.top.equalTo(cell.mas_top).with.offset(0);
        make.right.equalTo(cell.mas_right).with.offset(-30);
    }];
}
//创建右侧switch
-(void)createSwitchOnCell:(UITableViewCell *)cell index:(NSInteger)index{
    cell.accessoryType = UITableViewCellAccessoryNone;
    UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    aSwitch.tag = index+100;
    [cell addSubview:aSwitch];
    if ([[DRLocaldData achieveSwitchData] containsObject:[NSString stringWithFormat:@"%ld",(long)index+100]]) {
        aSwitch.on = YES;
    }else {
        aSwitch.on = NO;
    }
    [aSwitch addTarget:self action:@selector(touchUpSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [aSwitch mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.mas_top).with.offset(10);
        make.bottom.equalTo(cell.mas_bottom).with.offset(10);
        make.right.equalTo(cell.mas_right).with.offset(-10);
    }];
}
-(void)touchUpSwitch:(UISwitch *)aSwitch {
    NSString *aSwitchTag = [NSString stringWithFormat:@"%ld",(long)aSwitch.tag];
    if ([[DRLocaldData achieveSwitchData] containsObject:aSwitchTag]) { //开--->关
        aSwitch.on = NO;
        [self.switchStatusArray removeObject:aSwitchTag];
        
    }else {//关--->开
        aSwitch.on = YES;
        [self.switchStatusArray addObject:aSwitchTag];
        
        switch (aSwitch.tag) {
            case 100: //广告屏蔽
                
                break;
            case 101: //只在WIFI模式下载
                
                break;
            case 105: //无图模式
                
                break;
            case 106:  //无痕浏览
                
                break;
   
            default:
                break;
        }
        
    }
    [DRLocaldData saveSwitchData:self.switchStatusArray];
}

-(void)cleanCacheAlert {
    UIAlertController *cacheAlert = [UIAlertController alertControllerWithTitle:@"是否清理文件缓存" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cacheAlert addAction:cancelAction];

    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clearCache];
        self.cacheLabel.text = @"";
        [self.moreTableView reloadData];
    }];;
    [cacheAlert addAction:OKAction];
    
    [self presentViewController:cacheAlert animated:YES completion:nil];
}
- (double)getCacheSize {
    //清除缓存
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    //image 缓存
    NSUInteger fileSize = [imageCache getSize];
    
    //本地下载缓存
    NSString *myCache = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/MyCaches"];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDictionary *dict = [fm attributesOfItemAtPath:myCache error:nil];
    //sdwebimage缓存+ 本地下载缓存
    fileSize += dict.fileSize;
    double size = fileSize/1024.0/1024.0;
    return size;
}

-(void)clearCache{
    //清理sd 的内存
    [[SDImageCache sharedImageCache] clearMemory];
    //清理sd 缓存
    [[SDImageCache sharedImageCache] clearDisk];
    //清除 本地其他缓存
    //本地下载缓存
    NSString *myCache = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/MyCaches"];
    [[NSFileManager defaultManager] removeItemAtPath:myCache error:nil];
    
    [Tools showView:@"清理完成"];
}
//亮度
-(void)createBrightnessView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Brightness" bundle:[NSBundle mainBundle]];
    BrightnessVC *brightnessVC = (BrightnessVC *)[storyboard instantiateViewControllerWithIdentifier:@"BrightnessVC"];
    MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:brightnessVC];
    formSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    formSheetController.presentationController.portraitTopInset = [UIScreen mainScreen].bounds.size.height - 160;
    formSheetController.presentationController.contentViewSize = [UIScreen mainScreen].bounds.size;
    formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideAndBounceFromBottom;
    //    brightnessVC.delegate = self;
    [self presentViewController:formSheetController animated:YES completion:nil];
}
//官网
-(void)openWithUrl:(NSString *)urlString {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
    SearchVC *searchVC = (SearchVC *)[storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    searchVC.urlString = urlString;
    [self.navigationController pushViewController:searchVC animated:YES];
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
