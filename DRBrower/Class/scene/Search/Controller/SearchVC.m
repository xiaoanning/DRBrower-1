//
//  SearchVC.m
//  DRBrower
//
//  Created by QiQi on 2017/1/4.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "SearchVC.h"
#import "HomeToolBar.h"

@interface SearchVC ()<HomeToolBarDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *searchWV;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet HomeToolBar *homeToolBar;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.searchWV.backgroundColor = [UIColor whiteColor];
    self.homeToolBar.delegate = self;
    self.searchWV.delegate = self;
    
    [self webViewData];

    // Do any additional setup after loading the view.
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

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];    [self.titleBtn setTitle:currentURL forState:UIControlStateNormal];
    [self.titleBtn setTitle:currentURL forState:UIControlStateNormal];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
    
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
    
}

- (void)touchUpPageButtonAction {
    
}

- (void)touchUpHomeButtonAction {
    
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
