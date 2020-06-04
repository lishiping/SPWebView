//
//  UIViewController+NavigationAndStatusBarStyle.m
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


#import "UIViewController+SPNavigationBarStyle.h"

@implementation UIViewController (SPNavigationBarStyle)

#pragma mark - 设置导航栏样式的方法
- (void)sp_navBar:(EM_BarStyle)bar_style
{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (bar_style)
        {
            case BarStyle_Default:
                break;
                
            case BarStyle_Hide://隐藏无动画
                
                [self.navigationController setNavigationBarHidden:YES animated:NO];
                self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
                break;
                
            case BarStyle_Hide_Animated://隐藏有动画
                
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
                break;
                
            case BarStyle_BlackBGColor_WhiteTitle://黑色背景，白色文字
                
                [self.navigationController setNavigationBarHidden:NO animated:NO];
                self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
                self.navigationController.navigationBar.translucent = NO;
                self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
                break;
                
            case BarStyle_TranslucentBGColor_WhiteTitle://透明背景，白色文字
                
                [self.navigationController setNavigationBarHidden:NO animated:NO];
                self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
                self.navigationController.navigationBar.translucent = YES;
                self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
                [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
                
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
                break;
                
            case BarStyle_WhiteBGColor_BlackTitle://白色背景，黑色文字
                
                [self.navigationController setNavigationBarHidden:NO animated:NO];
                self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
                self.navigationController.navigationBar.translucent = NO;
                self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
                self.navigationController.navigationBar.alpha = 1.f;
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
                break;
                
            case BarStyle_TranslucentBGColor_BlackTitle://透明背景，黑色文字
                
                [self.navigationController setNavigationBarHidden:NO animated:NO];
                self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
                self.navigationController.navigationBar.translucent = YES;
                self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
                [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
                
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
                break;
                
            case BarStyle_Translucent:
                
                [self.navigationController setNavigationBarHidden:NO animated:NO];
                self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
                self.navigationController.navigationBar.translucent = YES;
                self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
                [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                //去掉导航栏下方的线  UIBarMetricsDefault
                self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
                
                break;
            default:;
        }
    });
}

- (void)sp_navBar_bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barTintColor = bgColor;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //去掉导航栏下方的线  UIBarMetricsDefault
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    });
}


@end
