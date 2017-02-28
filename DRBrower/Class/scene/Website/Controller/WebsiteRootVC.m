//
//  WebsiteRootVC.m
//  DRBrower
//
//  Created by QiQi on 2017/1/9.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "WebsiteRootVC.h"
#import "WebsiteRecommendVC.h"
#import "WebsiteCustomVC.h"
#import "CollectVC.h"

@interface WebsiteRootVC ()

@end

@implementation WebsiteRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self setupSubVC];
    // Do any additional setup after loading the view.
}

- (void)setupSubVC {
    WebsiteRecommendVC *recommendVC =
    [[WebsiteRecommendVC alloc] initWithNibName:@"WebsiteRecommendVC"
                                         bundle:nil];
    recommendVC.websiteArray = self.websiteArray;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Menu" bundle:[NSBundle mainBundle]];
    CollectVC *collectVC = (CollectVC *)[storyboard instantiateViewControllerWithIdentifier:@"CollectVC"];
    
    WebsiteCustomVC *customVC = [[WebsiteCustomVC alloc] init];
    
    NSArray *viewControllers = @[recommendVC, collectVC, customVC];
    self.viewControllers = viewControllers;
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
