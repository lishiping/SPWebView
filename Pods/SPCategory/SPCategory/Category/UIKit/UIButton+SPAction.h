//
//  UIButton+SPAction.h
//  jgdc
//
//  Created by lishiping on 2019/9/10.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBlockDefine.h"
#import "NSObject+SPAssociatedObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SPAction)

/**
 扩展点击事件
 
 @param action 返回对象
 */
-(void)sp_button_onClickBlock:(SPIdBlock)action;

@end

NS_ASSUME_NONNULL_END
