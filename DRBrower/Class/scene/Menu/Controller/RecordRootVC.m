//
//  RecordRootVC.m
//  DRBrower
//
//  Created by QiQi on 2017/2/23.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "RecordRootVC.h"

#import "HistoryVC.h"
#import "CollectVC.h"

@interface RecordRootVC ()

@end

@implementation RecordRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Menu" bundle:[NSBundle mainBundle]];
    CollectVC *collectVC = (CollectVC *)[storyboard instantiateViewControllerWithIdentifier:@"CollectVC"];
    collectVC.recordRootVC = self;
    
    HistoryVC *historyVC = (HistoryVC *)[storyboard instantiateViewControllerWithIdentifier:@"HistoryVC"];
    historyVC.recordRootVC = self;
    
    NSArray *viewControllers = @[collectVC,historyVC];
    self.viewControllers = viewControllers;
    
    UIBarButtonItem *emptyButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_trash"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(emptyButtonAction:)];
    self.navigationItem.rightBarButtonItem = emptyButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.title = NSLocalizedString(@"收藏/历史", nil);
    
    // Do any additional setup after loading the view.
}

- (void)emptyInCollectButtonClick:(CollectRelaodTabelBlock)block {
    _collectReloadBlock = [block copy];
}

- (void)emptyInHistoryButtonClick:(HistoryRelaodTabelBlock)block {
    _historyReloadBlock = [block copy];
}

- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)emptyButtonAction:(UIBarButtonItem *)barButton {
    if (self.selectedIndex == 0) {
        if (_collectReloadBlock) {
            _collectReloadBlock();
        }
    }else {
        if (_historyReloadBlock) {
            _historyReloadBlock();
        }
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
