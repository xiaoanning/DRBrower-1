//
//  NavView.m
//  DRBrower
//
//  Created by QiQi on 2017/3/12.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "NavView.h"

@implementation NavView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)navAlphaY:(CGFloat)y{
    if (y > 64) {
        self.alpha =  1.0;
        
    }else{
        self.alpha =  y/64;
    }
}


- (IBAction)didClickQRcodeButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpNavQRcodeButtonAction)]){
        [_delegate touchUpNavQRcodeButtonAction];
    }
}

- (IBAction)didclickSearchButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpNavSearchButtonAction)]){
        [_delegate touchUpNavSearchButtonAction];
    }
}

@end
