//
//  ForgetPsdVC.h
//  DRBrower
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPsdVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nPasswordLabel;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *resetPsdButton;
@end
