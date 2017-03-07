//
//  LoginVC.m
//  DRBrower
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "LoginVC.h"
#import "RegsitVC.h"
#import "ForgetPsdVC.h"
#import "LoginModel.h"

@interface LoginVC ()<UITextViewDelegate>
@property (nonatomic,strong) NSMutableArray *accountArray;
@property (nonatomic,strong) NSMutableArray *passwordArray;
@property (nonatomic,assign) BOOL isPhoneNum;
@end

@implementation LoginVC
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
        
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.accountArray = [NSMutableArray arrayWithCapacity:5];
    self.passwordArray = [NSMutableArray arrayWithCapacity:5];
}
- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popViewControllerAnimated:YES];
}
//忘记密码
- (IBAction)touchUpForgetButton:(id)sender {
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"ForgetPsd" bundle:[NSBundle mainBundle]];
    ForgetPsdVC *forgetPsdVC = (ForgetPsdVC *)[stroyboard instantiateViewControllerWithIdentifier:@"ForgetPsdVC"];
    [self.navigationController pushViewController:forgetPsdVC animated:YES];
}
//登陆
- (IBAction)touchUpLoginButton:(id)sender {
    [self userLogin];
}
//注册
- (IBAction)touchUpRegistButton:(id)sender {
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Regsit" bundle:[NSBundle mainBundle]];
    RegsitVC *regsitVC = (RegsitVC *)[stroyboard instantiateViewControllerWithIdentifier:@"RegsitVC"];
    [self.navigationController pushViewController:regsitVC animated:YES];
}
#pragma mark - -------------TextView--------
#pragma mark - -------------TextView--------
-(void)textViewDidBeginEditing:(UITextView *)textView {
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    switch (textView.tag) {
        case 100:
            if ([textView.text length] >= 11) {//判断字符个数
                if (self.isPhoneNum) {
                    NSLog(@"%@",[self.accountArray lastObject]);
                }else {
                    [Tools showView:@"手机号输入有误"];
                    textView.text = @"";
                    [self.accountArray removeAllObjects];
                    [self.accountLabel setHidden:NO];
                }
            }
            return YES;
            break;
        case 101:
            if (1 == range.length) {//按下回格键
                return YES;
            }
            if ([text isEqualToString:@"\n"]) {//按下return键
                [textView resignFirstResponder];
                return NO;
            }else {
                if ([textView.text length] < 250) {//判断字符个数
                    NSLog(@"%@",text);
                    return YES;
                }
            }
            break;
        default:
            break;
    }
    return NO;
}
- (void)textViewDidChange:(UITextView *)textView{
    switch (textView.tag) {
        case 100:
            if ([textView.text length] == 0) {
                [self.accountLabel setHidden:NO];
            }else if ([textView.text length] >= 11){
                [textView resignFirstResponder];
                [self.accountArray addObject:textView.text];
                self.isPhoneNum = [Tools phoneNumberValidation:[self.accountArray lastObject]];
            }else {
                [self.accountLabel setHidden:YES];
                [self.accountArray addObject:textView.text];
            }
            break;
        case 101:
            if ([textView.text length] == 0) {
                [self.passwordLabel setHidden:NO];
            }else {
                [self.passwordLabel setHidden:YES];
                [self.passwordArray addObject:textView.text];
            }
            break;
        default:
            break;
    }
}
//登录
-(void)userLogin{
    NSString *urlString = [NSString stringWithFormat:@"%@%@&tel=%@&dev_id=%@&pwd=%@",PHP_BASE_URL,URL_LOGIN,[self.accountArray lastObject],DEV_ID,[self.passwordArray lastObject]];
    [LoginModel userLoginUrl:urlString parameters:@{} block:^(NSDictionary *dic, NSError *error) {
        NSLog(@"%@",dic);
        [Tools showView:[dic objectForKey:@"msg"]];
        if ([[dic objectForKey:@"msg"] isEqualToString:@"登录成功"]) {
            [self.navigationController popViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
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
