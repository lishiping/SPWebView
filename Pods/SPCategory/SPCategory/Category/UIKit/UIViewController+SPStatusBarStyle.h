//
//  UIViewController+SPStatusBarStyle.h
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

// 状态栏的样式
typedef NS_ENUM(NSInteger, EM_StatusBarStyle)
{
    StatusBarStyle_Default = 0,               // 默认黑色
    StatusBarStyle_LightContent = 1,          // 白色
    StatusBarStyle_Hidden = 2,                // 隐藏
};

@interface UIViewController (SPStatusBarStyle)

//当前设置方法可以选用，已经在ios9之后废弃了，可以使用新的方法实现
- (void)sp_statusBar:(EM_StatusBarStyle)statusBar_style;    // 状态栏的样式

//设置状态栏背景色
- (void)sp_setStatusBarBackgroundColor:(UIColor *)color;

@end
