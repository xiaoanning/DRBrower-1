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
#import "ShareVC.h"

#import "HomeToolBar.h"

#import "RecordModel.h"
#import "ShareModel.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface SearchVC ()<HomeToolBarDelegate,UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,MenuVCDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet HomeToolBar *homeToolBar;
@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (strong, nonatomic) WKWebView *searchWV;
@property (strong, nonatomic) UIButton *exitFullScreenButton;
@property (strong, nonatomic) RecordModel *record;
@property (strong, nonatomic) ShareModel *shareModel;
@property (strong, nonatomic) NSMutableArray *historyArray;
@property (strong, nonatomic) MZFormSheetPresentationViewController *formSheetController;
@property (strong, nonatomic) MZFormSheetPresentationViewController *shareFormSheetController;


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
    
}

- (void)isFullScreen {
    BOOL isFullScreen = [[NSUserDefaults standardUserDefaults] boolForKey:kFullScreen];
    if (isFullScreen == NO) {
        
        self.searchWV.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
    }else {
        [self setupExitFullScreenButton];
        self.searchWV.frame = self.view.bounds;
    }
    
}

- (void)setupSubviews {
    self.homeToolBar.delegate = self;

    self.searchWV = [WKWebView new];
    self.searchWV.backgroundColor = [UIColor whiteColor];
    self.searchWV.navigationDelegate = self;
    self.searchWV.UIDelegate = self;
    self.searchWV.scrollView.delegate = self;
    [self isFullScreen];
    [self.view addSubview:self.searchWV];
    
}

- (void)setupExitFullScreenButton {
    self.exitFullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.exitFullScreenButton setImage:[UIImage imageNamed:@"btn_exit_full_screen"] forState:UIControlStateNormal];
    [self.exitFullScreenButton addTarget:self action:@selector(exitFullScreenButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    self.exitFullScreenButton.frame = CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-150, 50, 50);
    [self.searchWV addSubview:self.exitFullScreenButton];

}

- (void)exitFullScreenButtonAciton:(UIButton *)button {

    [UIView animateWithDuration:0.2//动画持续时间
                    animations:^{
                        //执行的动画
                        self.navBar.center = CGPointMake(SCREEN_WIDTH*0.5, 32);
                        self.homeToolBar.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT-22);
                        self.searchWV.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
                    }completion:^(BOOL finished){
                        //动画执行完毕后的操作
                        [self.exitFullScreenButton removeFromSuperview];

                    }];
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
    NSString *url = webView.URL.absoluteString;
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
    if (![title isEqualToString:@""] && ![url isEqualToString:@""]) {
        [self newOneRecordWithUrl:url title:title];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

- (void)newOneRecordWithUrl:(NSString *)url title:(NSString *)title {
    self.record = [[RecordModel alloc] init];
    self.record.url = url;
    self.record.title = title;
    self.record.time = [Tools atPresentTimestamp];
    [self.record realmAddRecord];

    self.shareModel = [ShareModel shareModelWithShareUrl:url
                                                   title:title
                                                    desc:[NSString stringWithFormat:@"快来看看我分享给你的网站：%@",title]
                                                 content:[NSString stringWithFormat:@"快来看看我分享给你的网站：%@",title]
                                                  image:nil];
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
    self.formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:menuVC];
    self.formSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    
    self.formSheetController.presentationController.portraitTopInset = [UIScreen mainScreen].bounds.size.height - 20 - MENU_HEIGHT;
    
    self.formSheetController.presentationController.contentViewSize = [UIScreen mainScreen].bounds.size;
    
    
    self.formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideAndBounceFromBottom;
    
    menuVC.delegate = self;
    
    [self presentViewController:self.formSheetController animated:YES completion:nil];
    
}

- (void)touchUpPageButtonAction {
    [self snapshotScreen];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Search" bundle:[NSBundle mainBundle]];
    ShareVC *shareVC = (ShareVC *)[storyboard instantiateViewControllerWithIdentifier:@"ShareVC"];
    self.shareFormSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:shareVC];
    self.shareFormSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    
    self.shareFormSheetController.presentationController.portraitTopInset = [UIScreen mainScreen].bounds.size.height - 240;
    self.shareFormSheetController.presentationController.contentViewSize = [UIScreen mainScreen].bounds.size;
    self.shareFormSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideAndBounceFromBottom;
    
    shareVC.shareModel = self.shareModel;
    [self presentViewController:self.shareFormSheetController animated:YES completion:nil];

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

- (void)touchUpFullScreenButtonAction:(BOOL)isfull {
    
    [UIView animateWithDuration:0.5//动画持续时间
                         delay:0.0//动画延迟执行的时间
                       options:UIViewAnimationOptionCurveEaseInOut//动画的过渡效果
                    animations:^{
                        if (isfull == YES) {
                            //执行的动画
                            self.navBar.center = CGPointMake(SCREEN_WIDTH*0.5, 32);
                            self.homeToolBar.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT-22);
                            self.searchWV.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
                        }else {
                            self.navBar.center = CGPointMake(SCREEN_WIDTH*0.5, -32);
                            self.homeToolBar.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT+22);
                            self.searchWV.frame = self.view.bounds;
                        }

                    }completion:^(BOOL finished){
                        //动画执行完毕后的操作
                        if (isfull == NO) {
                            [self setupExitFullScreenButton];

                        }

                    }];
    
}

- (void)touchUpRefreshDataButtonAction {
    [self.searchWV reload];
    
}

- (void)showView:(NSString *)title{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(title, @"HUD message title");
    hud.tintColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:2.f];
    
}

#pragma mark -scrollView 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    BOOL isFullScreen = [[NSUserDefaults standardUserDefaults] boolForKey:kFullScreen];
    
    if (isFullScreen == YES) {
        [UIView animateWithDuration:0.5//动画持续时间
                              delay:0.0//动画延迟执行的时间
                            options:UIViewAnimationOptionCurveEaseInOut//动画的过渡效果
                         animations:^{
                        
                                 self.navBar.center = CGPointMake(SCREEN_WIDTH*0.5, -32);
                                 self.homeToolBar.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT+22);
                                 self.searchWV.frame = self.view.bounds;
                             
                         }completion:^(BOOL finished){
                             //动画执行完毕后的操作
                                 [self.exitFullScreenButton removeFromSuperview];
                                 [self setupExitFullScreenButton];
                             
                         }];
    }

}

/**
 *  截取当前屏幕的内容
 */
- (void)snapshotScreen
{
    // 判断是否为retina屏, 即retina屏绘图时有放大因子
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(self.view.window.bounds.size);
    }
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.shareModel.image = image;
    // 保存到相册
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id){

 // Invoked immediately prior to initiating a segue. Return NO to prevent the segue from firing. The default implementation returns YES. This method is not invoked when -performSegueWithIdentifier:sender: is used.

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
