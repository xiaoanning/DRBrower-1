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
    self.title = @"推荐";
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
    collectVC.rootVCType = CollectVCRootVCTypeWebsite;
    
    WebsiteCustomVC *customVC = [[WebsiteCustomVC alloc] initWithNibName:@"WebsiteCustomVC" bundle:nil];
    
    NSArray *viewControllers = @[recommendVC, collectVC, customVC];
    self.viewControllers = viewControllers;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)tabBar:(AXTabBar *)tabBar didSelectItem:(UITabBarItem *)item {

    [super tabBar:tabBar didSelectItem:item];
    self.title = tabBar.selectedItem.title;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    
    switch (self.selectedIndex) {
        case 0:
            self.title = @"推荐";
            break;
        case 1:
            self.title = @"收藏";
            break;
        case 2:
            self.title = @"自定义";
            break;
        default:
            break;
    }
    
    NSLog(@"%ld",self.selectedIndex);

}

- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popViewControllerAnimated:YES];
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
