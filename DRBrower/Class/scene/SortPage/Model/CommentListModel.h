//
//  CommentListModel.h
//  DRBrower
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentListModel : MTLModel<MTLJSONSerializing>

@property(strong, nonatomic) NSArray *data;

@end
