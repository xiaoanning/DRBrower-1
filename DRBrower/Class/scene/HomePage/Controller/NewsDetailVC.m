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
    
    [self.newsDetailWV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsModel.url]]];
    self.newsDetailWV.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
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
