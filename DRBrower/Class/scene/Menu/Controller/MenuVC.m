//
//  MenuVC.m
//  DRBrower
//
//  Created by QiQi on 2017/1/17.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "MenuVC.h"
#import "HistoryVC.h"

@interface MenuVC ()


@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    NSLog(@"%@",self.str);
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(asdf) name:@"12345" object:nil];
    
    // Do any additional setup after loading the view.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"12345" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
-(void)asdf{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)didClickBackButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)historyButtonAction:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Menu" bundle:[NSBundle mainBundle]];
//    HistoryVC *historyVC = (HistoryVC *)[storyboard instantiateViewControllerWithIdentifier:@"HistoryVC"];
//
////    [self.navigationController pushViewController:menuVC animated:YES];
//    historyVC.menuVC = self;
//    [self presentViewController:historyVC animated:YES completion:nil];
}

- (IBAction)collectButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpCollectButtonAction)]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpCollectButtonAction];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    

}


@end