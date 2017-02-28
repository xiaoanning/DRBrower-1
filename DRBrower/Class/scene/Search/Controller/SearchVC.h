//
//  SearchVC.h
//  DRBrower
//
//  Created by QiQi on 2017/1/4.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PYSearch.h"
#import "NewsModel.h"
#import "RecordModel.h"

@interface SearchVC : UIViewController

@property (nonatomic, strong)NSString *searchText;
@property (nonatomic, strong)PYSearchViewController *searchViewController;

@property (nonatomic, strong)NewsModel *newsModel;
@property (nonatomic, strong)RecordModel *recordModel;

- (NSURLSessionDataTask *)getMIMETypeWithPath:(NSURL *)path
                                    block:(void (^)(NSString *mimeType,
                                                    NSError *error))completion;

@end
