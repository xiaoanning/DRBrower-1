//
//  Define.h
//  DRBrower
//
//  Created by QiQi on 2017/3/6.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define mark - 色值转换颜色
static inline UIColor *colorWithvalue(NSString *value) {
    return [UIColor colorFromHexString:value];
}

#endif /* Define_h */
