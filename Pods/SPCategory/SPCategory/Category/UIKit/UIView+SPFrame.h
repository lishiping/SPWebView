//
//  UIView+SPFrame.h
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

@interface UIView (SPFrame)

/*快捷的使用视图frame的get和set方法*/

@property CGFloat sp_x;
@property CGFloat sp_y;
@property CGPoint sp_origin;

@property CGFloat sp_width;
@property CGFloat sp_height;
@property CGSize  sp_size;

@property CGFloat sp_top;
@property CGFloat sp_bottom;
@property CGFloat sp_left;
@property CGFloat sp_right;

@property CGFloat sp_centerX;
@property CGFloat sp_centerY;
@property CGPoint sp_center;


//快捷方法
- (void)sp_bringToFront;

- (void)sp_sendToBack;

- (void)sp_removeAllSubViews;


@end


