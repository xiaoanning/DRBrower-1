//
//  NewsDetailVC.m
//  DRBrower
//
//  Created by QiQi on 2016/12/23.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "NewsDetailVC.h"

@interface NewsDetailVC ()


@property (weak, nonatomic) IBOutlet UIWebView *newsDetailWV;

@end

@implementation NewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.newsDetailWV.backgroundColor = [UIColor whiteColor];
    
    if (self.sortModel && ![self.sortModel.url isEqualToString:@""]) {
        [self.newsDetailWV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.sortModel.url]]];
    }else if(self.newsModel && ![self.newsModel.url isEqualToString:@""]){
        [self.newsDetailWV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsModel.url]]];
    }
}
- (IBAction)BackButtonItemInToolBarActon:(id)sender {
    if ([self.newsDetailWV canGoBack]) {
        [self.newsDetailWV goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }    
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
