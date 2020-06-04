//
//  UIImage+SPGIF.h
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//
//If you think this open source library is of great help to you, please open the URL to click the Star,your approbation can encourage me, the author will publish the better open source library for guys again
//如果您认为本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory
//github address//https://github.com/lishiping/SPBaseClass

#import <UIKit/UIKit.h>

@interface UIImage (SPGIF)


/**
 从gif文件名初始化image对象

 @param name gif文件名
 @return 返回gif生成的image对象
 */
+ (UIImage *)sp_animatedGIFNamed:(NSString *)name;

/**
 初始化图片数据如果是gif转为动画图片，如果是静图转为静态图片,默认不缩放

 @param data 图片数据
 @return 返回gif生成的iamge对象
 */
+ (UIImage *)sp_animatedGIFWithData:(NSData *)data;

/**
 初始化图片数据如果是gif转为动画图片，如果是静图转为静态图片,可以设置缩放比例

 @param data 图片数据
 @param scale 缩放比例
 @return 动画图片对象
 */
+ (UIImage *)sp_animatedGIFWithData:(NSData *)data scale:(CGFloat)scale;

/**
 gif图按照尺寸截取

 @param size 要截取的尺寸
 @return 返回的gif图
 */
- (UIImage *)sp_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
