//
//  CommentVC.h
//  DRBrower
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortModel.h"

@interface CommentVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *commentListTableView;

@property (weak, nonatomic) IBOutlet UILabel *writeCommentLabel;

@property (nonatomic,strong)SortModel *sortModel;

@end
