//
//  UIViewController+NavigationAndStatusBarStyle.h
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//
//If you feel this open source library is of great help to you, please open the URL to the point of a great, great encouragement your recognition to the author, the author will release better open source library for you again
//如果您感觉本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会再发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory
//github address//https://github.com/lishiping/SPBaseClass

#import <UIKit/UIKit.h>

// 导航栏的样式
typedef NS_ENUM(NSInteger, EM_BarStyle)
{
    BarStyle_Default = 0,                     // 默认无操作
    BarStyle_Hide = 1,                        // 隐藏
    BarStyle_Hide_Animated,                   // 隐藏，有动画效果
    BarStyle_BlackBGColor_WhiteTitle,         // 黑色背景，白色文字
    BarStyle_TranslucentBGColor_WhiteTitle,   // 透明背景，白色文字
    BarStyle_WhiteBGColor_BlackTitle,         // 白色背景，黑色文字
    BarStyle_TranslucentBGColor_BlackTitle,   // 透明背景，黑色文字
    BarStyle_Translucent,                     // 透明背景,文字颜色未处理
};


@interface UIViewController (SPNavigationBarStyle)

// 设置导航栏的样式
- (void)sp_navBar:(EM_BarStyle)bar_style;


/**
 自定义导航栏颜色
 
 @param bgColor 背景色
 @param titleColor 文字颜色（前景色）
 */
- (void)sp_navBar_bgColor:(UIColor *)bgColor
               titleColor:(UIColor*)titleColor;


@end
