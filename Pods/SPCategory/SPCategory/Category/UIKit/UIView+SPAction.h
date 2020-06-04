//
//  UIView+SPAction.h
//  jgdc
//
//  Created by lishiping on 2019/9/23.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBlockDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SPAction)


/**
 扩展点击事件

 @param block 返回对象
 */
-(UIGestureRecognizer*)sp_view_onClickBlock:(SPIdBlock)block;


/**
 长按事件

 @param block 返回对象
 */
-(UIGestureRecognizer*)sp_view_longPressBlock:(SPIdBlock)block;

@end

NS_ASSUME_NONNULL_END
