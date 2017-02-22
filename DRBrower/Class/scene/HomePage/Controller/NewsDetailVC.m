//
//  NewsDetailVC.m
//  DRBrower
//
//  Created by QiQi on 2016/12/23.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "NewsDetailVC.h"
#import "HomeToolBar.h"
#import "MenuVC.h"
@interface NewsDetailVC ()<HomeToolBarDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *newsDetailWV;
@property (weak, nonatomic) IBOutlet HomeToolBar *homeToolBar;

@end

@implementation NewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeToolBar.delegate = self;
    
    [self.newsDetailWV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsModel.url]]];
    self.newsDetailWV.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)touchUpBackButtonAction {
    
    if ([self.newsDetailWV canGoBack]) {
        [self.newsDetailWV goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)touchUpGoButtonActionr {
    if ([self.newsDetailWV canGoForward]) {
        [self.newsDetailWV goForward];
    }
}

- (void)touchUpMenuButtonAction {
    //菜单
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Menu" bundle:[NSBundle mainBundle]];
    MenuVC *menuVC = (MenuVC *)[storyboard instantiateViewControllerWithIdentifier:@"MenuVC"];
    MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:menuVC];
    formSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    
    formSheetController.presentationController.portraitTopInset = [UIScreen mainScreen].bounds.size.height - 240;
    
    formSheetController.presentationController.contentViewSize = [UIScreen mainScreen].bounds.size;
    
    
    formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideAndBounceFromBottom;
    
    [self presentViewController:formSheetController animated:YES completion:nil];
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
