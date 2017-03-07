//
//  RegsitVC.h
//  DRBrower
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegsitVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordAgainLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UITextView *passwordTextView;
@property (weak, nonatomic) IBOutlet UITextView *passwordArginTV;

@end
