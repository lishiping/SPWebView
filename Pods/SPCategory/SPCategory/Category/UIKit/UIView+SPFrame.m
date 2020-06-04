//
//  UIView+SPFrame.m
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



#import "UIView+SPFrame.h"

@implementation UIView (SPFrame)

- (CGFloat)sp_x
{
    return self.frame.origin.x;
}

- (void)setSp_x:(CGFloat)sp_x
{
    CGRect rect = self.frame;
    rect.origin.x = sp_x;
    [self setFrame:rect];
}

- (CGFloat)sp_y
{
    return self.frame.origin.y;
}

- (void)setSp_y:(CGFloat)sp_y
{
    CGRect rect = self.frame;
    rect.origin.y = sp_y;
    [self setFrame:rect];
}

- (CGPoint)sp_origin
{
    return self.frame.origin;
}

- (void)setSp_origin:(CGPoint)sp_origin
{
    CGRect rect = self.frame;
    rect.origin = sp_origin;
    [self setFrame:rect];
}

- (CGFloat)sp_width
{
    return self.frame.size.width;
}

- (void)setSp_width:(CGFloat)sp_width
{
    CGRect rect = self.frame;
    rect.size.width = sp_width;
    [self setFrame:rect];
}

- (CGFloat)sp_height
{
    return self.frame.size.height;
}

- (void)setSp_height:(CGFloat)sp_height
{
    CGRect rect = self.frame;
    rect.size.height = sp_height;
    [self setFrame:rect];
}

- (CGSize)sp_size
{
    return [self frame].size;
}

- (void)setSp_size:(CGSize)sp_size
{
    CGRect rect = self.frame;
    rect.size = sp_size;
    [self setFrame:rect];
}

- (CGFloat)sp_top
{
    return self.frame.origin.y;
}

- (void)setSp_top:(CGFloat)sp_top
{
    CGRect frame = self.frame;
    frame.origin.y = sp_top;
    self.frame = frame;
}

- (CGFloat)sp_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSp_bottom:(CGFloat)sp_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = sp_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)sp_left
{
    return self.frame.origin.x;
}

- (void)setSp_left:(CGFloat)sp_left
{
    CGRect frame = self.frame;
    frame.origin.x = sp_left;
    self.frame = frame;
}

- (CGFloat)sp_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSp_right:(CGFloat)sp_right
{
    CGRect frame = self.frame;
    frame.origin.x = sp_right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)sp_centerX
{
    return self.center.x;
}

- (void)setSp_centerX:(CGFloat)sp_centerX
{
    self.center = CGPointMake(sp_centerX, self.sp_centerY);
}

- (CGFloat)sp_centerY
{
    return self.center.y;
}

- (void)setSp_centerY:(CGFloat)sp_centerY
{
    self.center = CGPointMake(self.sp_centerX, sp_centerY);
}

- (CGPoint)sp_center
{
    return self.center;
}

- (void)setSp_center:(CGPoint)sp_center
{
    self.center = sp_center;
}

- (void)sp_bringToFront
{
    [self.superview bringSubviewToFront:self];
}

- (void)sp_sendToBack
{
    [self.superview sendSubviewToBack:self];
}

- (void)sp_removeAllSubViews
{
    for (UIView *subview in self.subviews){
        [subview removeFromSuperview];
    }
}


@end


