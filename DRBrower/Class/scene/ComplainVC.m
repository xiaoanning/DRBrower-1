//
//  ComplainVC.m
//  DRBrower
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 QiQi. All rights reserved.
//


#import "ComplainVC.h"

@interface ComplainVC () {
    NSMutableString *contentStr;
    NSInteger clickCount1;
    NSInteger clickCount2;
    NSInteger clickCount3;
    NSInteger clickCount4;
    NSInteger clickCount5;
    NSInteger clickCount6;
    NSInteger clickCount7;

}
@property (nonatomic,strong) NSArray *contentArray;
@end

@implementation ComplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contentStr = [[ NSMutableString alloc] init];
    
    clickCount1 = clickCount2 = clickCount3 = clickCount4 = clickCount5 = clickCount6 = clickCount7 =0;

    self.contentArray = @[@"内容低俗",@"标题夸张",@"广告软件",@"不感兴趣",@"内容虚假",@"诱导分享",@"内容过时"];
    
}
- (IBAction)touchUpTheFirstButton:(id)sender {
    [contentStr appendString:@"1"];
    clickCount1 += 1;
    [self changeButtonState:(UIButton *)sender clickCount:clickCount1];
}
- (IBAction)touchUpTheSecendButton:(id)sender {
    [contentStr appendString:@"2"];
    clickCount2 += 1;
    [self changeButtonState:(UIButton *)sender clickCount:clickCount2];
}
- (IBAction)touchUpTheThirdButton:(id)sender {
    clickCount3 += 1;
    [contentStr appendString:@"3"];
    [self changeButtonState:(UIButton *)sender clickCount:clickCount3];
}
- (IBAction)touchUpTheFourButton:(id)sender {
    clickCount4 += 1;
    [contentStr appendString:@"4"];
    [self changeButtonState:(UIButton *)sender clickCount:clickCount4];
}
- (IBAction)touchUpTheFiveButton:(id)sender {
    clickCount5 += 1;
    [contentStr appendString:@"5"];
    [self changeButtonState:(UIButton *)sender clickCount:clickCount5];
}
- (IBAction)touchUpTheSixButton:(id)sender {
    clickCount6 += 1;
    [contentStr appendString:@"6"];
    [self changeButtonState:(UIButton *)sender clickCount:clickCount6];
}
- (IBAction)touchUpTheSevenButton:(id)sender {
    clickCount7 += 1;
    [contentStr appendString:@"7"];
    [self changeButtonState:(UIButton *)sender clickCount:clickCount7];
}
//提交
- (IBAction)touchUpCommitButton:(id)sender {
    if (![contentStr isEqualToString:@""]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.delegete && [self.delegete respondsToSelector:@selector(commitComplainWithContent:)]) {
            [self.delegete commitComplainWithContent:contentStr];
        }
    }
}
-(void)changeButtonState:(UIButton *)button clickCount:(NSInteger)clickCount{
    NSLog(@"clickCount-------------%ld",(long)clickCount);
    if (clickCount%2) {
        [button setBackgroundImage:[UIImage imageNamed:@"sort_informSelected"] forState:UIControlStateNormal];
    }else {
        [button setBackgroundImage:[UIImage imageNamed:@"sort_informUSelected"] forState:UIControlStateNormal];
        clickCount += 1;
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
