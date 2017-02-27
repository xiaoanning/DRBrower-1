//
//  ZYImagesPlayer.h
//  GameGuide
//
//  Created by QiQi on 2016/12/7.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYImagesPlayerDelegae, ZYImagesPlayerIndictorPattern;

@interface ZYImagesPlayer : UIView

/**
 *  是否自动滚动 默认YES
 */
@property (nonatomic, assign) BOOL autoScroll;
/**
 *  滚动间隔时间 默认2秒
 */
@property (nonatomic, assign) NSTimeInterval scrollIntervalTime;
/**
 *  是否隐藏分页指示器 默认NO
 */
@property (nonatomic, assign) BOOL hidePageControl;
@property (weak, nonatomic) id<ZYImagesPlayerDelegae> delegate;
@property (weak, nonatomic) id<ZYImagesPlayerIndictorPattern> indicatorPattern;
/**
 *  当前展示的图片数组
 */
@property (strong, nonatomic, readonly) NSArray *images;
/**
 *  添加本地图片数组
 */
- (void)addLocalImages:(NSArray<NSString *> *)images;
/**
 *  添加网络图片数组
 */
- (void)addNetWorkImages:(NSArray <NSString *> *)images placeholder:(UIImage *)placeholder;
/**
 *  点击事件回调
 */
- (void)imageTapAction:(void (^) (NSInteger index))block;
/**
 *  移除定时器
 */
- (void)removeTimer;
/**
 *  计算缓存图片总大小（MB）
 */
- (CGFloat)calculateCacheImagesMemory;
/**
 *  清除图片缓存
 */
- (void)removeCacheMemory;
@end

/**
 *  代理
 */
@protocol ZYImagesPlayerDelegae <NSObject>

@optional

/**
 *  图片点击回调
 */
- (void)imagesPlayer:(ZYImagesPlayer *)player didSelectImageAtIndex:(NSInteger)index;

@end

/**
 *  指示器样式
 */
@protocol ZYImagesPlayerIndictorPattern <NSObject, UITableViewDelegate>

@required
/**
 *  设置分页指示器的样式
 */
- (UIView *)indicatorViewInImagesPlayer:(ZYImagesPlayer *)imagesPlayer;

@optional

/**
 *  图片交换完成时调用
 */
- (void)imagesPlayer:(ZYImagesPlayer *)imagesPlayer didChangedIndex:(NSInteger)index count:(NSInteger)count;

@end

@interface UIImageView (WebCaches)

- (void)setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;


@end
