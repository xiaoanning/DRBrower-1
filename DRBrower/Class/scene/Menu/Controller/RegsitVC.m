
//
//  RegsitVC.m
//  DRBrower
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "RegsitVC.h"
#import "LoginModel.h"

@interface RegsitVC ()<UITextViewDelegate>
@property (nonatomic,strong) NSMutableArray *phoneNumArray;//手机号
@property (nonatomic,strong) NSMutableArray *passwordArray;//密码
@property (nonatomic,strong) NSMutableArray *passwordArginArray; //确认密码
@property (nonatomic,strong) NSMutableArray *codeArray; //验证码

@property (nonatomic,assign) NSInteger timeCount;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) BOOL isPhoneNum;
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
    
    self.phoneNumArray = [NSMutableArray arrayWithCapacity:5];
    self.passwordArray = [NSMutableArray arrayWithCapacity:5];
    self.passwordArginArray = [NSMutableArray arrayWithCapacity:5];
    self.codeArray = [NSMutableArray arrayWithCapacity:5];
}

- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popViewControllerAnimated:YES];
}
//获取验证码
- (IBAction)touchUpCodeButton:(id)sender {
    if (self.isPhoneNum) {
        [self getTelCode];
        [self timeFailBeginFrom:60];
    }else {
        [Tools showView:@"请输入正确手机号"];
    }
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
#pragma mark - -------------TextView--------
-(void)textViewDidBeginEditing:(UITextView *)textView {
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    switch (textView.tag) {
        case 200:
            if ([textView.text length] >= 11) {//判断字符个数
                if (self.isPhoneNum) {
                    NSLog(@"%@",[self.phoneNumArray lastObject]);
                }else {
                    [Tools showView:@"手机号输入有误"];
                    textView.text = @"";
                    [self.phoneNumArray removeAllObjects];
                    [self.phoneNumLabel setHidden:NO];
                }
            }
            return YES;
            break;
        case 201:
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
        case 202:
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
        case 203:
            if (1 == range.length) {//按下回格键
                return YES;
            }
            if ([text isEqualToString:@"\n"]) {//按下return键
                [textView resignFirstResponder];
                return NO;
            }else {
                if ([textView.text length] < 7) {//判断字符个数
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
        case 200:
            if ([textView.text length] == 0) {
                [self.phoneNumLabel setHidden:NO];
            }else if ([textView.text length] >= 11){
                [textView resignFirstResponder];
                [self.phoneNumArray addObject:textView.text];
                self.isPhoneNum = [Tools phoneNumberValidation:[self.phoneNumArray lastObject]];
            }else {
                [self.phoneNumLabel setHidden:YES];
                [self.phoneNumArray addObject:textView.text];
            }
            break;
        case 201:
            if ([textView.text length] == 0) {
                [self.passwordLabel setHidden:NO];
            }else {
                [self.passwordLabel setHidden:YES];
                [self.passwordArray addObject:textView.text];
            }
            break;
        case 202:
            if ([textView.text length] == 0) {
                [self.passwordAgainLabel setHidden:NO];
            }else {
                [self.passwordAgainLabel setHidden:YES];
                [self.passwordArginArray addObject:textView.text];
                NSLog(@"%@   %@",[self.passwordArginArray lastObject],[self.passwordArray lastObject]);
                if ([[self.passwordArginArray lastObject] length] == [[self.passwordArray lastObject] length]) {
                    [textView resignFirstResponder];
                }
            }
            break;
        case 203:
            if ([textView.text length] == 0) {
                [self.codeLabel setHidden:NO];
            }else if ([textView.text length] >= 6) {
                [textView resignFirstResponder];
                [self.codeArray addObject:textView.text];
            }else {
                [self.codeLabel setHidden:YES];
                [self.codeArray addObject:textView.text];
            }
            break;
        default:
            break;
    }
}
//获取短信验证码
-(void)getTelCode {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&devtype=%@&dev_id=%@",PHP_BASE_URL,URL_GETCODE,[self.phoneNumArray lastObject],@"1",DEV_ID];
    [LoginModel getTelCodeUrl:urlString parameters:@{} block:^(NSDictionary *dic, NSError *error) {
        NSLog(@"%@",dic);
        [Tools showView:[dic objectForKey:@"msg"]];
    }];
}
//用户注册
-(void)userRegsit {
    NSString *urlString = [NSString stringWithFormat:@"%@%@&tel=%@&devtype=%@&dev_id=%@&pwd=%@&repwd=%@&code=%@&sex=%@",PHP_BASE_URL,URL_REGSIT,[self.phoneNumArray lastObject],@"1",DEV_ID,[self.passwordArray lastObject],[self.passwordArginArray lastObject],[self.codeArray lastObject],@"1"];
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
