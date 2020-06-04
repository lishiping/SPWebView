//
//  SPBundleTools.h
//
//  Created by lishiping on 2019/6/28.
//  Copyright © 2019 lishiping. All rights reserved.
//
/*
 快捷获取文件方法
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPBundleTools : NSObject

/// 获取png图片
/// @param bundleName 子bundle名字
/// @param name 文件名不带后缀
+ (UIImage *)getPngImageBundle:(NSString *)bundleName
                     imageName:(NSString *)name;

/// 获取图片
/// @param bundleName 子bundle名字
/// @param name 图片名字
/// @param type 图片类型
+ (UIImage *)getImageBundle:(NSString *)bundleName
                  imageName:(NSString *)name
                       type:(NSString *)type;

/// 获取json的字典
/// @param bundleName 子bundle名字
/// @param name json文件名字
+ (NSDictionary *)getJsonBundle:(NSString *)bundleName jsonName:(NSString *)name;


/// 获取数据
/// @param bundleName 子bundle名字
/// @param name 文件名带上后缀的
+ (NSData *)getDataBundle:(NSString *)bundleName fileName:(NSString *)name;

/// 获取文件路径
/// @param bundleName bundle名字
/// @param name 带文件类型后缀的名字
+ (NSString *)getPathBundle:(NSString *)bundleName fileName:(NSString *)name;

+ (NSBundle *)getMainBundle;

+ (NSBundle *)getBundleForName:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
