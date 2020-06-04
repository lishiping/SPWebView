//
//  UIImageView+SPAction.h
//  jgdc
//
//  Created by lishiping on 2019/9/20.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBlockDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (SPAction)

/**
 扩展点击事件
 
 @param block 返回对象
 */
-(UIGestureRecognizer*)sp_imageView_onClickBlock:(SPIdBlock)block;

@end

NS_ASSUME_NONNULL_END
