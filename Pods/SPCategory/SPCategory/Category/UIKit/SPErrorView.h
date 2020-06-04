//
//  SPErrorView.h
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

//错误页
#import <UIKit/UIKit.h>

typedef void (^SPButtonClickedBlock)(id sender);

@interface SPErrorView : UIView

/**
 带有icon和title的错误页

 @param frame 位置
 @param image 图片
 @param title 标题
 @param block 回调
 @return 实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame
                       image:(UIImage*)image
                       title:(NSString*)title
                       block:(SPButtonClickedBlock)block;


/**
 带有icon和标题，子标题，两个返回按钮的错误页

 @param frame 位置
 @param image 图片
 @param title 标题
 @param subtitle 子标题
 @param button1_title 第一个按钮标题
 @param button2_title 第二个按钮标题
 @param button1_click_block 第一个按钮回调
 @param button2_click_block 第二个按钮回调
 @return 实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame
                       image:(UIImage*)image
                       title:(NSString *)title
                    subtitle:(NSString *)subtitle
               button1_title:(NSString *)button1_title
               button2_title:(NSString *)button2_title
         button1_click_block:(SPButtonClickedBlock)button1_click_block
         button2_click_block:(SPButtonClickedBlock)button2_click_block;

@end
