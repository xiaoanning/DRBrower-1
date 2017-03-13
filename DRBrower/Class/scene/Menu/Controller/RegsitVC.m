
//
//  RegsitVC.m
//  DRBrower
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "RegsitVC.h"
#import "LoginModel.h"
#import "UserInfo.h"

@interface RegsitVC ()<UITextFieldDelegate>
@property (nonatomic,copy) NSString *phoneNum;//手机号
@property (nonatomic,copy) NSString *password;//密码
@property (nonatomic,copy) NSString *passwordAgain; //确认密码
@property (nonatomic,copy) NSString *code; //验证码

@property (nonatomic,assign) NSInteger timeCount;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation RegsitVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popViewControllerAnimated:YES];
}
//获取验证码
- (IBAction)touchUpCodeButton:(id)sender {
//    if (self.isPhoneNum) {
        [self getTelCode];
        [self timeFailBeginFrom:60];
//    }else {
//        [Tools showView:@"请输入正确手机号"];
//    }
}
//注册
- (IBAction)touchUpRegsitButton:(id)sender {
    [self userRegsit];
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
        case 200:
            self.phoneNum = textField.text;
            break;
        case 201:
            self.password = textField.text;
            break;
        case 202:
            self.passwordAgain = textField.text;
            break;
        case 203:
            self.code = textField.text;
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
//用户注册
-(void)userRegsit {
    [self.phoneNumTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    [self.pwdAgainTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&tel=%@&dev_id=%@&pwd=%@&repwd=%@&code=%@&sex=%@",PHP_BASE_URL,URL_REGSIT,TOKEN,self.phoneNum,DEV_ID,self.password,self.passwordAgain,self.code,[[UserInfo getUserGender] isEqualToString:@"男"]?@"0":@"1"];
    [LoginModel userRegsitUrl:urlString parameters:@{} block:^(NSDictionary *dic, NSError *error) {
        NSLog(@"%@",dic);
        [Tools showView:[dic objectForKey:@"msg"]];
        if ([[dic objectForKey:@"msg"] isEqualToString:@"注册成功"]) {
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
