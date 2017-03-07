//
//  LoginVC.h
//  DRBrower
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@property (weak, nonatomic) IBOutlet UITextView *accountTextView;
@property (weak, nonatomic) IBOutlet UITextView *passwordTextView;
@end
