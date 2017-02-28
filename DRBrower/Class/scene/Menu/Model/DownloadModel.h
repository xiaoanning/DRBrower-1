//
//  DownloadModel.h
//  DRBrower
//
//  Created by QiQi on 2017/2/28.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadModel : NSObject

+ (void)downloadFile:(NSURL *)url
               block:(void (^)(id response,
                               NSError *error))completion;

@end
