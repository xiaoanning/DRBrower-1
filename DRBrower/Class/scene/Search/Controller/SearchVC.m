//
//  SearchVC.m
//  DRBrower
//
//  Created by QiQi on 2017/1/4.
//  Copyright © 2017年 QiQi. All rights reserved.
//
#import <WebKit/WebKit.h>

#import "SearchVC.h"
#import "MenuVC.h"

#import "HomeToolBar.h"

#import "RecordModel.h"

@interface SearchVC ()<HomeToolBarDelegate,UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,MenuVCDelegate>
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet HomeToolBar *homeToolBar;

@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) WKWebView *searchWV;
@property (strong, nonatomic) RecordModel *record;
@property (strong, nonatomic) NSMutableArray *historyArray;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self setupSubviews];
    
    if (self.newsModel != nil||self.recordModel != nil) {
        self.searchText = self.newsModel.url?self.newsModel.url:self.recordModel.url;
    }
    [self webViewData];

    self.historyArray = [NSMutableArray arrayWithCapacity:5];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    NSLog(@"historyArray = %@",self.historyArray);
    
    [DRLocaldData saveHistoryData:self.historyArray];
}

- (void)setupSubviews {
    self.homeToolBar.delegate = self;

    self.searchWV = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-44-64)];
    self.searchWV.backgroundColor = [UIColor whiteColor];
    self.searchWV.navigationDelegate = self;
    self.searchWV.UIDelegate = self;
    [self.view addSubview:self.searchWV];

}

- (void)webViewData {
    
    NSURL *url = [NSURL URLWithString:[[Tools urlValidation:self.searchText] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self.searchWV loadRequest:[NSURLRequest requestWithURL:url]];
    
    
}

- (IBAction)didClickTitleButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didClickReloadButtonAction:(id)sender {
    [self.searchWV reload];
}

#pragma mark - WKWebView delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSString *currentURL = webView.URL.absoluteString;
    [self.titleBtn setTitle:currentURL forState:UIControlStateNormal];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *title = webView.title;
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
    
    [self newOneRecordWithUrl:webView.URL.absoluteString title:webView.title];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

- (void)newOneRecordWithUrl:(NSString *)url title:(NSString *)title {
    self.record = [[RecordModel alloc] init];
    self.record.url = url;
    self.record.title = title;
    [self.historyArray insertObject:self.record atIndex:0];
}

#pragma mark - custom delegate

- (void)touchUpBackButtonAction {
    if ([self.searchWV canGoBack]) {
        [self.searchWV goBack];
    }else {
        [self.searchViewController dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)touchUpGoButtonActionr {
    if ([self.searchWV canGoForward]) {
        [self.searchWV goForward];
    }
}

- (void)touchUpMenuButtonAction {
    //TODO:菜单
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Menu" bundle:[NSBundle mainBundle]];
    MenuVC *menuVC = (MenuVC *)[storyboard instantiateViewControllerWithIdentifier:@"MenuVC"];
    MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:menuVC];
    formSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    
    formSheetController.presentationController.portraitTopInset = [UIScreen mainScreen].bounds.size.height - 240;
    
    formSheetController.presentationController.contentViewSize = [UIScreen mainScreen].bounds.size;
    
    
    formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideAndBounceFromBottom;
    
    menuVC.delegate = self;
    
    [self presentViewController:formSheetController animated:YES completion:nil];
}

- (void)touchUpPageButtonAction {
    
}

- (void)touchUpHomeButtonAction {
    [self.searchViewController dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//menu收藏
- (void)touchUpCollectButtonAction {
    if ([[DRLocaldData alloc] saveCollectData:self.record] == YES) {
        [self showView:COLLECT_SUCCESS];
    }else {
        [self showView:COLLECT_FAILED];
    }
}

-(void)showView:(NSString *)title{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(title, @"HUD message title");
    hud.tintColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:2.f];
    
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
