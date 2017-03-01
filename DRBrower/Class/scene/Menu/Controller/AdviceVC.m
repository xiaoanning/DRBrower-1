//
//  AdviceVC.m
//  DRBrower
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "AdviceVC.h"

@interface AdviceVC ()<UITextViewDelegate>
@property (nonatomic,strong) NSMutableArray *inputArray;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@end

@implementation AdviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"举报程序猿";
    
    self.inputArray = [NSMutableArray arrayWithCapacity:5];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.adviceTextView.layer.borderColor =UIColor.grayColor.CGColor;
    self.adviceTextView.layer.borderWidth = 0.5;
    [self createPlaceHolderLabel];
}
-(void)createPlaceHolderLabel{
    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.adviceTextView.frame)-10, 40)];
    self.placeHolderLabel.enabled = NO;
    self.placeHolderLabel.text = @"哪里用着不爽，吐槽给我们（别忘了留下QQ）";
    self.placeHolderLabel.adjustsFontSizeToFitWidth = YES;
    self.placeHolderLabel.font =  [UIFont systemFontOfSize:15];
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    [self.adviceTextView addSubview: self.placeHolderLabel];
    [self.adviceTextView sendSubviewToBack:self.placeHolderLabel];
}
- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//发送
- (IBAction)touchUpSendButton:(id)sender {
    NSLog(@"----inputArray-------%@",[self.inputArray lastObject]);
}
//申请加群
- (IBAction)touchUpJoinQQButton:(id)sender {
    [Tools joinGroup:nil key:@"299032484"];
}
#pragma mark - -------------TextView--------
-(void)textViewDidBeginEditing:(UITextView *)textView {
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    if ([text isEqualToString:@"\n"]) {//按下return键
        [textView resignFirstResponder];
        return NO;
    }else {
        if ([textView.text length] < 140) {//判断字符个数
            NSLog(@"%@",text);
            return YES;
        }
    }
    return NO;
}
- (void)textViewDidChange:(UITextView *)textView{
    [self.inputArray addObject:textView.text];
    
    if ([textView.text length] == 0) {
        [self.placeHolderLabel setHidden:NO];
    }else{
        [self.placeHolderLabel setHidden:YES];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView {
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
