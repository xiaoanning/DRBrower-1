//
//  GenderVC.m
//  DRBrower
//
//  Created by QiQi on 2017/3/9.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "GenderVC.h"

@interface GenderVC ()
@property (weak, nonatomic) IBOutlet UIImageView *manSelectImage;
@property (weak, nonatomic) IBOutlet UIImageView *wamenSelectImage;

@end

@implementation GenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)maleButtonAction:(id)sender {
    
    self.manSelectImage.image = [UIImage imageNamed:@"man_select"];
    self.wamenSelectImage.image = [UIImage imageNamed:@"not_select"];
    [UserInfo userInfoDefaults:@"男"];
}

- (IBAction)femaleButtonAction:(id)sender {
    self.manSelectImage.image = [UIImage imageNamed:@"not_select"];
    self.wamenSelectImage.image = [UIImage imageNamed:@"waman_select"];
    [UserInfo userInfoDefaults:@"女"];
}

- (IBAction)OKButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

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
