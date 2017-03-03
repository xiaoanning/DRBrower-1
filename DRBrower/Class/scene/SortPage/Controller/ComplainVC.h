//
//  ComplainVC.h
//  DRBrower
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommitComplainDelegate <NSObject>

-(void)commitComplainWithContent:(NSString *)contentStr;

@end

@interface ComplainVC : UIViewController

@property (nonatomic,weak) id<CommitComplainDelegate>delegete;
@property (nonatomic,assign) NSInteger currentIndex;
@end
