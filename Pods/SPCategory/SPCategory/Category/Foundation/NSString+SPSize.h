//
//  NSString+SPSize.h
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



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SPSize)

#pragma mark - Size（计算大小）
/**
 *  Returns the size of the string occupied(返回字符串所占用的尺寸，相比很多方法，这个算最精准的了)
 *
 *  @param font    字体
 *  @param size 最大尺寸 font 字体 breakMode 折行 aligment 对齐方式 lineSpacing 行间距
 */
- (CGSize)sp_getSize_maxSize:(CGSize)size
                        font:(UIFont *)font;

- (CGSize)sp_getSize_maxSize:(CGSize)size
                        font:(UIFont *)font
                   breakMode:(NSLineBreakMode)breakMode;

- (CGSize)sp_getSize_maxSize:(CGSize)size
                        font:(UIFont *)font
                   alignment:(NSTextAlignment)alignment;

- (CGSize)sp_getSize_maxSize:(CGSize)size
                        font:(UIFont *)font
                   breakMode:(NSLineBreakMode)breakMode
                   alignment:(NSTextAlignment)alignment;

- (CGSize)sp_getSize_maxSize:(CGSize)size
                        font:(UIFont *)font
                   breakMode:(NSLineBreakMode)breakMode
                   alignment:(NSTextAlignment)alignment
                 lineSpacing:(CGFloat)lineSpacing;

@end
