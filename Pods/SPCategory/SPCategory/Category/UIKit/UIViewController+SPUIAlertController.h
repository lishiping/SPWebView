//
//  UIViewController+SPUIAlertController.h
//  SPCategory
//
//  Created by shiping1 on 2017/11/21.
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
#import "NSObject+SPAssociatedObject.h"

typedef void (^SPIdClickedBlock)(UIAlertAction * _Nullable action);

@interface UIViewController (SPUIAlertController)

//这个方法是为了解决当前VC已经消失了(主动控制警告框消失的方法)，而由于其他原因Alert还未消失，可以在在viewdiddisappear里面加入移除alertview
-(void)sp_removespAlertVC;

/*本类别的特点：
1.旨在实现快捷的方法，一个方法代替了以往的创建初始化显示等过程，实现代码复用
2.使用ViewController的类别，使代码不要都集中在ViewController，如果VC代码很臃肿，不利于可读性可维护性
3.由于以往开发发现了有在网络层拦截弹出alert，后期维护艰难，旨在MVC模式下，不让view层被引入到网络层在底层拦截弹出警告框，这也是苹果开发文档的要求
4.方法顺序是使用频率顺序，不常用的方法作为其他常用方法的基础方法
5.缺点只扩展了一个和两个按钮的方法，两个以上按钮的没做处理，因为多个按钮的无法控制，而且使用频率不高，可以自行创建
 */

#pragma mark - AlertView

/**
 只有标题且只有一个按钮的alertView，只有一个选择方案的（例如强制更新等）
 
 @param title 标题
 @param ok_title 按钮名字
 @param ok_block 按钮回调
 */
-(UIAlertController *_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                     ok_title:(NSString*_Nullable)ok_title
                     ok_block:(SPIdClickedBlock _Nullable )ok_block;

/**
 有标题有详情信息，但只有一个按钮的alertView，只有一个选择方案的（例如强制更新等）
 
 @param title 标题
 @param message 信息
 @param ok_title 按钮名字
 @param ok_block 按钮回调
 */
-(UIAlertController *_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                      message:(NSString*_Nullable)message
                     ok_title:(NSString*_Nullable)ok_title
                     ok_block:(SPIdClickedBlock _Nullable )ok_block;

/**
 有标题有详情信息，但只有一个按钮的alertView，加入了动画控制，带完成回调,只有一个选择方案的（例如强制更新等）
 
 @param title 标题
 @param message 信息
 @param flag 动画
 @param ok_title 按钮名字
 @param ok_block 按钮回调
 @param completion 完成回调
 */
-(UIAlertController *_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                      message:(NSString*_Nullable)message
                     animated: (BOOL)flag
                     ok_title:(NSString*_Nullable)ok_title
                     ok_block:(SPIdClickedBlock _Nullable )ok_block
                   completion:(void (^ __nullable)(void))completion;

/**
 快捷警告框，两个按钮
 
 @param title 标题
 @param message 信息
 @param ok_title 确认或者自定义按钮名字
 @param cancel_title 取消或者自定义按钮名字
 @param ok_block 确认或者自定义按钮回调
 @param cancel_block 取消或者自定义按钮回调
 */
-(UIAlertController *_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                      message:(NSString*_Nullable)message
                     ok_title:(NSString*_Nullable)ok_title
                 cancel_title:(NSString*_Nullable)cancel_title
                     ok_block:(SPIdClickedBlock _Nullable)ok_block
                 cancel_block:(SPIdClickedBlock _Nullable )cancel_block;

/**
 快捷的弹出警告框的方法
 
 @param title 标题
 @param message 详情信息
 @param ok_title 确定按钮或者自定义名字
 @param cancel_title 取消按钮或者自定义名字
 @param animated 动画
 @param ok_block 确定按钮或者自定义按钮回调
 @param cancel_block 取消按钮或者自定义按钮回调
 @param completion UIAlertViewController完成弹出后的回调（不用可传nil）
 */
-(UIAlertController *_Nullable)sp_showAlertView_title:(NSString*_Nullable)title
                      message:(NSString*_Nullable)message
                     ok_title:(NSString*_Nullable)ok_title
                 cancel_title:(NSString*_Nullable)cancel_title
                     animated: (BOOL)animated
                     ok_block:(SPIdClickedBlock _Nullable)ok_block
                 cancel_block:(SPIdClickedBlock _Nullable)cancel_block
                   completion:(void (^ __nullable)(void))completion;


#pragma mark - ActionSheet

/**
 快捷弹出ActionSheet控件，默认使用UIAlertActionStyleDestructive风格

 @param title 标题
 @param message 信息
 @param ok_title 确认或者自定义名字
 @param cancel_title 取消或者自定义名字
 @param ok_block 确认或者自定义按钮的回调
 @param cancel_block 取消或者自定义按钮的回调
 */
-(UIAlertController *_Nullable)sp_showActionSheet_title:(NSString*_Nullable)title
                        message:(NSString*_Nullable)message
                       ok_title:(NSString*_Nullable)ok_title
                   cancel_title:(NSString*_Nullable)cancel_title
                       ok_block:(SPIdClickedBlock _Nullable)ok_block
                   cancel_block:(SPIdClickedBlock _Nullable)cancel_block;

/**
 快捷弹出ActionSheet控件，默认使用UIAlertActionStyleDestructive风格
 
 @param title 标题
 @param message 信息
 @param ok_title_destructive 确认或者自定义名字
 @param cancel_title 取消或者自定义名字
 @param ok_block 确认或者自定义按钮的回调
 @param cancel_block 取消或者自定义按钮的回调
 */
-(UIAlertController *_Nullable)sp_showActionSheet_title:(NSString*_Nullable)title
                        message:(NSString*_Nullable)message
           ok_title_destructive:(NSString*_Nullable)ok_title_destructive
                   cancel_title:(NSString*_Nullable)cancel_title
                       ok_block:(SPIdClickedBlock _Nullable)ok_block
                   cancel_block:(SPIdClickedBlock _Nullable)cancel_block;

/**
 快捷弹出ActionSheet控件，默认使用UIAlertActionStyleDefault风格
 
 @param title 标题
 @param message 信息
 @param ok_title_default 确认或者自定义名字
 @param cancel_title 取消或者自定义名字
 @param ok_block 确认或者自定义按钮的回调
 @param cancel_block 取消或者自定义按钮的回调
 */
-(UIAlertController *_Nullable)sp_showActionSheet_title:(NSString*_Nullable)title
                        message:(NSString*_Nullable)message
               ok_title_default:(NSString*_Nullable)ok_title_default
                   cancel_title:(NSString*_Nullable)cancel_title
                       ok_block:(SPIdClickedBlock _Nullable)ok_block
                   cancel_block:(SPIdClickedBlock _Nullable)cancel_block;

/**
 快捷弹出ActionSheet控件，带有动画控制，默认按钮风格，以及完成的回调
 
 @param title 标题
 @param message 信息
 @param ok_title 确认或者自定义名字
 @param cancel_title 取消或者自定义名字
 @param animated 动画
 @param ok_title_style 默认按钮的风格
 @param ok_block 确认或者自定义按钮的回调
 @param cancel_block 取消或者自定义按钮的回调
 */
-(UIAlertController *_Nullable)sp_showActionSheet_title:(NSString*_Nullable)title
                        message:(NSString*_Nullable)message
                       ok_title:(NSString*_Nullable)ok_title
                   cancel_title:(NSString*_Nullable)cancel_title
                       animated: (BOOL)animated
                 ok_title_style:(UIAlertActionStyle)ok_title_style
                       ok_block:(SPIdClickedBlock _Nullable)ok_block
                   cancel_block:(SPIdClickedBlock _Nullable)cancel_block
                     completion:(void (^ __nullable)(void))completion;


@end
