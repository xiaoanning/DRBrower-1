//
//  BrightnessVC.m
//  DRBrower
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#define kMaxTransparent 0.5f

#import "BrightnessVC.h"

@interface BrightnessVC ()
@property (nonatomic, strong) CALayer *brightnessLayer;
@end

@implementation BrightnessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat systemValue = [UIScreen mainScreen].brightness;
    NSLog(@"systemValue-----%f",systemValue);
    
    self.brightnessSlider.minimumValue = 0;
    self.brightnessSlider.maximumValue = 1;
    self.brightnessSlider.value = systemValue;// 设置初始值
    self.brightnessSlider.continuous = YES;
    
    [self.brightnessSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

}
-(void)sliderValueChanged:(UISlider *)slider {
    [[UIScreen mainScreen] setBrightness:slider.value];
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
