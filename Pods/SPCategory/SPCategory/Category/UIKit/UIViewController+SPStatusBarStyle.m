//
//  UIViewController+SPStatusBarStyle.m
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

#import "UIViewController+SPStatusBarStyle.h"

@implementation UIViewController (SPStatusBarStyle)

- (void)sp_statusBar:(EM_StatusBarStyle)statusBar_style
{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (statusBar_style)
        {
            case StatusBarStyle_Default:
            default:;
                [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
                break;
                
            case StatusBarStyle_LightContent:
                [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
                break;
                
            case StatusBarStyle_Hidden:
                [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
                break;
        }
    });
}

- (void)sp_setStatusBarBackgroundColor:(UIColor *)color
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = color;
        }
    });
}

@end
