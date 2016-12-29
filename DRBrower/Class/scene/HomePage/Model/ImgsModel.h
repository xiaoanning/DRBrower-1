//
//  imgsModel.h
//  DRBrower
//
//  Created by QiQi on 2016/12/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgsModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, strong) NSString *width;//宽
@property(nonatomic, strong) NSString *height;//高
@property(nonatomic, strong) NSString *type;//类型
@property(nonatomic, strong) NSString *url;//地址

@end
