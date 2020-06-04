//
//  NSAttributedString+SPSize.h
//  jgdc
//
//  Created by lishiping on 2019/9/28.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (SPSize)

/**
 获取富文本字符串的宽高，需要传入定宽或者定高的size值

 @param size 定宽或者定高size
 @return 计算出来的宽高
 */
- (CGSize)sp_getSize_maxSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
