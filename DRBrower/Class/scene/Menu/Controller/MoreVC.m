//
//  MoreVC.m
//  DRBrower
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "MoreVC.h"
#import "BrightnessVC.h"

@interface MoreVC ()

@end

@implementation MoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"更多";
    
    self.moreTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"identifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @"调节亮度";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Brightness" bundle:[NSBundle mainBundle]];
    BrightnessVC *brightnessVC = (BrightnessVC *)[storyboard instantiateViewControllerWithIdentifier:@"BrightnessVC"];

    MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:brightnessVC];
    formSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    formSheetController.presentationController.portraitTopInset = [UIScreen mainScreen].bounds.size.height - 160;
    formSheetController.presentationController.contentViewSize = [UIScreen mainScreen].bounds.size;
    formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideAndBounceFromBottom;
//    brightnessVC.delegate = self;
    
    [self presentViewController:formSheetController animated:YES completion:nil];
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
