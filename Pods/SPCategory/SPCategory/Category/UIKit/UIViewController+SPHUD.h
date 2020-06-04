//
//  UIViewController+HUD.h
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


#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface UIViewController (SPHUD)

/*本类别的特点：
 1.旨在实现快捷的显示方法，一个方法代替了以往的创建初始化弹出等过程，多页面复用
 2.写成了ViewController的类别，使代码不集中在ViewController，如果VC代码很臃肿，不利于可读性可维护性
 3.写成了ViewController的类别，旨在MVC模式下，不让view层被引入到网络层在底层显示，这也是苹果开发文档的要求
 4.方法顺序是使用频率顺序，不常用的方法作为其他常用方法的基础方法
 */

/*
 Here is based on the MBProgressHUD categories can be used directly, not add to the self. The view above;Direct use of [self sp_showPrompt: @ "login succeeds"].
 
 这里是在MBProgressHUD基础上可以直接使用的类别，不用在加到self.view上面；
 直接使用 [self sp_showPrompt:@"登录成功"];
 */

/*****************sp_showPrompt(显示提示消息)*********************/

- (void)sp_showToast:(NSString *)message;//不建议使用，只是为了跟安卓对应的单词
- (void)sp_showPrompt:(NSString *)message;
- (void)sp_showPrompt:(NSString *)message delayHide:(float)seconds;
- (void)sp_showPromptAddWindow:(NSString *)message;

/*****************sp_showHUD(显示活动指示器)*********************/
- (void)sp_showHUD;
- (void)sp_showHUD:(NSString *)message;
- (void)sp_showHUD:(NSString *)message animation:(BOOL)animated;

- (void)sp_showHUDInView:(UIView *)superView
                 message:(NSString *)message
               animation:(BOOL)animated;

- (void)sp_updateHUDMessage:(NSString *)message;

/*****************sp_showHUDGIF(显示GIF图片)*********************/

- (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr;

- (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
                      text:(NSString *)text
                detailText:(NSString *)detailText;

- (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
                      text:(NSString *)text
                detailText:(NSString *)detailText
                 delayHide:(float)seconds;

- (void)sp_showHUDGIF_data:(NSData *)gifData
                      text:(NSString *)text
                detailText:(NSString *)detailText;

- (void)sp_showHUDGIF_data:(NSData *)gifData
                      text:(NSString *)text
                detailText:(NSString *)detailText
                 delayHide:(float)seconds;

/*****************sp_showHUDCustomView(显示自定义视图)*********************/
- (void)sp_showHUDCustomView:(UIView *)customV;

- (void)sp_showHUDCustomView:(UIView *)customV
                        text:(NSString *)text
                  detailText:(NSString *)detailText;

- (void)sp_showHUDCustomView:(UIView *)customV
                        text:(NSString *)text
                  detailText:(NSString *)detailText
                   delayHide:(float)seconds;


/*****************sp_showMBProgressHUD(显示自定义指示器)*********************/
- (void)sp_showMBProgressHUD:(NSString *)message
                        mode:(MBProgressHUDMode)mode
                    progress:(float)progress
                   animation:(BOOL)animated;

/**
 快捷显示MBProgressHUD
 
 @param message 显示信息
 @param mode 显示模式
 
 
 /// UIActivityIndicatorView.（默认模式, 系统自带的指示器）
 MBProgressHUDModeIndeterminate,
 
 /// A round, pie-chart like, progress view.（圆形饼图）
 MBProgressHUDModeDeterminate,
 
 /// Horizontal progress bar.（水平进度条）
 MBProgressHUDModeDeterminateHorizontalBar,
 
 /// Ring-shaped progress view.（圆环）
 MBProgressHUDModeAnnularDeterminate,
 
 /// Shows a custom view.（自定义视图）
 MBProgressHUDModeCustomView,
 
 /// Shows only labels.（只显示文字）
 MBProgressHUDModeText
 
 @param progress 进度
 
 @param animated 动画
 
 @param font 文本字体
 
 @param textColor 文本颜色
 
 @param bezelViewColor hud块背景色
 
 @param backgroundColor 全屏整体背景色
 
 */
- (void)sp_showMBProgressHUD:(NSString *)message
                        mode:(MBProgressHUDMode)mode
                    progress:(float)progress
                   animation:(BOOL)animated
                        font:(UIFont*)font
                   textColor:(UIColor*)textColor
              bezelViewColor:(UIColor*)bezelViewColor
             backgroundColor:(UIColor*)backgroundColor;


/*****************hide(隐藏指示器)*********************/
- (void)sp_hideHUD;
- (void)sp_hideHUD:(BOOL)animated;
- (void)sp_hideHUD:(BOOL)animated delay:(float)seconds;
- (void)sp_hideHUDInView:(UIView *)view delay:(float)seconds animated:(BOOL)animated;

/**
 *  显示提示消息，白底黑字
 */
void showPrompt(UIView *superView, NSString *text, float showTime, BOOL animated);

/**
 *  显示 hud，带动画等待效果,白底黑字
 */
void showHUD(UIView *superView, NSString *text, float showTime, BOOL animated);

/**
 *  显示 hud，带动画等待效果,自定义颜色
 */
void showSimpleProgressHUD(UIView *superView, NSString *text,MBProgressHUDMode mode,float progress, float showTime, BOOL animated);

/**
 显示 ProgressHUD
 
 @param superView 父视图
 @param text 内容
 @param mode 模式
 @param showTime 显示时间
 @param animated 是否动画
 */
void showProgressHUD(UIView *superView, NSString *text,MBProgressHUDMode mode,float progress, float showTime, BOOL animated,UIFont *font,UIColor *textColor,UIColor *bezelViewColor,UIColor *backgroundColor);

/**
 显示 ProgressHUD
 
 @param superView 父视图
 @param customView 自定义视图
 @param text 内容
 @param detailText 详细内容
 @param showTime 显示时间
 @param animated 是否动画
 */
void showCustomHUD(UIView *superView, UIView *customView ,NSString *text, NSString *detailText,float showTime, BOOL animated);

/**
 隐藏活动视图

 @param superView 俯视图
 @param delayTime 延迟隐藏时间
 @param animated 是否动画
 */
void hideHUD(UIView *superView, float delayTime, BOOL animated);

@end
