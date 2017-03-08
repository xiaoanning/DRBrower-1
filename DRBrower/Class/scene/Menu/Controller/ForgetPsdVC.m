//
//  ForgetPsdVC.m
//  DRBrower
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "ForgetPsdVC.h"
#import "LoginModel.h"

@interface ForgetPsdVC ()<UITextFieldDelegate>
@property (nonatomic,copy) NSString *phoneNum;//手机号
@property (nonatomic,copy) NSString *nPassword;//密码
@property (nonatomic,copy) NSString *code; //验证码

@property (nonatomic,assign) NSInteger timeCount;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) BOOL isPhoneNum;

@end

@implementation ForgetPsdVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"忘记密码";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
}
- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popViewControllerAnimated:YES];
}
//获取验证码
- (IBAction)touchUpGetCodeButton:(id)sender {
//    if (self.isPhoneNum) {
        [self getTelCode];
        [self timeFailBeginFrom:60];
//    }else {
//        [Tools showView:@"请输入正确手机号"];
//    }
}
//重置密码
- (IBAction)touchUpResetButton:(id)sender {
    [self findPassword];
}
//添加计时器
- (void)timeFailBeginFrom:(NSInteger)timeCount {
    self.timeCount = timeCount;
    self.getCodeButton.enabled = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}
- (void)timerFired {
    if (self.timeCount != 1) {
        self.timeCount -= 1;
        self.getCodeButton.enabled = NO;
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"剩余%ld秒", (long)self.timeCount] forState:UIControlStateNormal];
    } else {
        self.getCodeButton.enabled = YES;
        [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
}
#pragma mark - -------------TextFieldDelegate--------
-(void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 300:
            self.phoneNum = textField.text;
            break;
        case 301:
            self.code = textField.text;
            break;
        case 302:
            self.nPassword = textField.text;
            break;
        default:
            break;
    }
}

//获取短信验证码
-(void)getTelCode {
    [self.phoneNumTextField resignFirstResponder];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&dev_id=%@&token=%@",PHP_BASE_URL,URL_GETCODE,self.phoneNum,DEV_ID,TOKEN];
    [LoginModel getTelCodeUrl:urlString parameters:@{} block:^(NSDictionary *dic, NSError *error) {
        NSLog(@"%@",dic);
        [Tools showView:[dic objectForKey:@"msg"]];
    }];
}
//重置密码
-(void)findPassword {
    [self.phoneNumTextField resignFirstResponder];
    [self.nPwdTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&dev_id=%@&tel=%@&pwd=%@&code=%@",PHP_BASE_URL,URL_FINDPWD,TOKEN,DEV_ID,self.phoneNum,self.nPassword,self.code];
    [LoginModel resetPasswordUrl:urlString parameters:@{} block:^(NSDictionary *dic, NSError *error) {
        NSLog(@"%@",dic);
        [Tools showView:[dic objectForKey:@"msg"]];
        if ([[dic objectForKey:@"msg"] isEqualToString:@"修改成功"]) {
            [self.navigationController popViewControllerAnimated:YES];
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
