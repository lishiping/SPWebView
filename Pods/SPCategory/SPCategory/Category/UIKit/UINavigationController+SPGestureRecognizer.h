//
//  UINavigationController+SPGestureRecognizer.h
//  SPCategory
//
//  Created by shiping li on 2020/5/8.
//  Copyright © 2020 lishiping. All rights reserved.
//

/*
 控制右滑手势返回上一页的方法
 当ViewController内部实现
 -(BOOL)gestureRecognizerShouldBegin;
 实例方法，如果返回是YES，则可以右滑返回，如果返回是NO，则不可以右滑返回
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (SPGestureRecognizer)<UIGestureRecognizerDelegate>

@end

NS_ASSUME_NONNULL_END
