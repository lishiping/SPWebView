//
//  NSString+SPSize.m
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


#import "NSString+SPSize.h"

@implementation NSString (SPSize)

- (CGSize)sp_getSize_maxSize:(CGSize)size font:(UIFont *)font
{
    return [self sp_getSize_maxSize:size font:font breakMode:NSLineBreakByWordWrapping];
}

- (CGSize)sp_getSize_maxSize:(CGSize)size font:(UIFont *)afont breakMode:(NSLineBreakMode)breakMode
{
    return [self sp_getSize_maxSize:size font:afont breakMode:breakMode alignment:NSTextAlignmentLeft];
}

- (CGSize)sp_getSize_maxSize:(CGSize)size font:(UIFont *)font alignment:(NSTextAlignment)alignment
{
    return [self sp_getSize_maxSize:size font:font breakMode:NSLineBreakByWordWrapping alignment:alignment];
}

- (CGSize)sp_getSize_maxSize:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)breakMode alignment:(NSTextAlignment)alignment
{
    return [self sp_getSize_maxSize:size font:font breakMode:breakMode alignment:alignment lineSpacing:-1];
}

- (CGSize)sp_getSize_maxSize:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)breakMode alignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing
{
    CGSize contentSize = CGSizeZero;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = breakMode?:NSLineBreakByWordWrapping;
    paragraphStyle.alignment = alignment?:NSTextAlignmentLeft;
    if (lineSpacing>0.0f) {
        paragraphStyle.lineSpacing = lineSpacing;
    }
    NSDictionary* attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    contentSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    contentSize = CGSizeMake((NSUInteger)contentSize.width + 1, (NSUInteger)contentSize.height + 1);
    return contentSize;
}


@end
