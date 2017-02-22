//
//  HomeToolBar.m
//  DRBrower
//
//  Created by QiQi on 2016/12/24.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import "HomeToolBar.h"

@implementation HomeToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)didclickHomeButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpHomeButtonAction)]){
        [_delegate touchUpHomeButtonAction];
    }
}

- (IBAction)didclickMenuButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpMenuButtonAction)]){
        [_delegate touchUpMenuButtonAction];
    }
}

- (IBAction)didclickBackButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpBackButtonAction)]){
        [_delegate touchUpBackButtonAction];
    }
}

- (IBAction)didclickGoButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpGoButtonActionr)]){
        [_delegate touchUpGoButtonActionr];
    }
}

- (IBAction)didclickPageButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpPageButtonAction)]){
        [_delegate touchUpPageButtonAction];
    }
}

@end
