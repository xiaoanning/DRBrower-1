//
//  RecordRootVC.h
//  DRBrower
//
//  Created by QiQi on 2017/2/23.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CollectRelaodTabelBlock)();
typedef void(^HistoryRelaodTabelBlock)();


@interface RecordRootVC : AXStretchableHeaderTabViewController

@property (nonatomic,copy) CollectRelaodTabelBlock collectReloadBlock;
@property (nonatomic,copy) HistoryRelaodTabelBlock historyReloadBlock;


- (void)emptyInCollectButtonClick:(CollectRelaodTabelBlock)block;
- (void)emptyInHistoryButtonClick:(HistoryRelaodTabelBlock)block;



@end
