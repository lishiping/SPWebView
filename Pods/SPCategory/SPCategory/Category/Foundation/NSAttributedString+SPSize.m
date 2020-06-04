//
//  NSAttributedString+SPSize.m
//  jgdc
//
//  Created by lishiping on 2019/9/28.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "NSAttributedString+SPSize.h"
#import <CoreText/CoreText.h>

@implementation NSAttributedString (SPSize)


- (CGSize)sp_getSize_maxSize:(CGSize)size
{
//    CGSize contentSize = CGSizeZero;
//    contentSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil].size;
//    contentSize = CGSizeMake((NSUInteger)contentSize.width + 1, (NSUInteger)contentSize.height + 1);//如果不加1有可能文字显示不全，这是一个坑
//    return contentSize;

    //coreText方法最准确，针对图文插入更准
    CGSize contentSize = CGSizeZero;
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    contentSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, size, nil);
    contentSize = CGSizeMake((NSUInteger)contentSize.width + 1, (NSUInteger)contentSize.height + 1);
    return contentSize;//如果不加1有可能文字显示不全，这是一个坑
}

@end
