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

@interface LoginVC ()<UITextFieldDelegate>
@property (nonatomic,copy) NSString *phoneNum;
@property (nonatomic,copy) NSString *pwd;
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
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 100) {
        self.phoneNum = textField.text;
    }else if (textField.tag == 101){
        self.pwd = textField.text;
    }
}

//登录
-(void)userLogin{
    [self.pwdTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&tel=%@&dev_id=%@&pwd=%@",PHP_BASE_URL,URL_LOGIN,TOKEN,self.phoneNum,DEV_ID,self.pwd];
    [LoginModel userLoginUrl:urlString parameters:@{} block:^(NSDictionary *dic, NSError *error) {
        NSLog(@"%@",dic);
        [Tools showView:[dic objectForKey:@"msg"]];
        if ([[dic objectForKey:@"msg"] isEqualToString:@"登录成功"]) {
            [self.navigationController popViewControllerAnimated:YES];
            //登陆成功,保存token到本地
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:[dic[@"data"] objectForKey:@"token"] forKey:LOGIN_TOKEN];
            [userDefaults setObject:[[dic[@"data"] objectForKey:@"userinfo"] objectForKey:@"uid"] forKey:LOGIN_UID];
            [userDefaults synchronize];
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
