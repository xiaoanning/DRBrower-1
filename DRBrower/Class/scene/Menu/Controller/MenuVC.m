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

@property (weak, nonatomic) IBOutlet UILabel *fullScreenLabel;


@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    BOOL isFullScreen = [[NSUserDefaults standardUserDefaults] boolForKey:kFullScreen];

    if (isFullScreen == YES) {
        self.fullScreenLabel.text = NSLocalizedString(@"退出全屏", nil);
    }else {
        self.fullScreenLabel.text = NSLocalizedString(@"全屏", nil);
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kFullScreen];

    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissView) name:DISMISS_VIEW object:nil];
    
    // Do any additional setup after loading the view.
}
-(void)dealloc{
   
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
-(void)dismissView{
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

- (IBAction)fullScreenButtonAction:(id)sender {
    
    BOOL isFullScreen = [[NSUserDefaults standardUserDefaults] boolForKey:kFullScreen];
    
    if (isFullScreen == YES) {
        self.fullScreenLabel.text = NSLocalizedString(@"退出全屏", nil);
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kFullScreen];

    }else {
        self.fullScreenLabel.text = NSLocalizedString(@"全屏", nil);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFullScreen];
        
    }
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpFullScreenButtonAction:)]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpFullScreenButtonAction:isFullScreen];
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
