//
//  DownloadModel.m
//  DRBrower
//
//  Created by QiQi on 2017/2/28.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "DownloadModel.h"

@implementation DownloadModel

+ (void)downloadFile:(NSURL *)url
               block:(void (^)(id, NSError *))completion {
    [[SRDownloadManager sharedManager] download:url
                                          state:^(SRDownloadState state) {
                                              NSLog(@"%ld",(long)state);
                                          } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
                                              NSLog(@"%@",[NSString stringWithFormat:@"%zdMB", receivedSize / 1024 / 1024]);
                                              NSLog(@"%@",[NSString stringWithFormat:@"%zdMB", expectedSize / 1024 / 1024]);
                                              NSLog(@"%@",[NSString stringWithFormat:@"%.f%%", progress * 100]);
                                              NSLog(@"%f",progress);
                                          } completion:^(BOOL isSuccess, NSString *filePath, NSError *error) {
                                              if (isSuccess) {
                                                  NSLog(@"filePath: %@", filePath);
                                              } else {
                                                  NSLog(@"error: %@", error);
                                              }
                                          }];
}

@end
