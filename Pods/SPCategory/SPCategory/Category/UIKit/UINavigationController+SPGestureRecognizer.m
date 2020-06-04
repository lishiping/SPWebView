//
//  UINavigationController+SPGestureRecognizer.m
//  SPCategory
//
//  Created by shiping li on 2020/5/8.
//  Copyright © 2020 lishiping. All rights reserved.
//

#import "UINavigationController+SPGestureRecognizer.h"


@implementation UINavigationController (SPGestureRecognizer)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

//控制右滑手势返回上一页的方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //因为这个右滑手势是针对于NavigationController的功能，故我们这里在NavigationController实现
    if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin:)]) {
        //如果topViewController是我们的基类SPBaseVC及SPBaseVC的子类，可以控制是否右滑返回
        //那如果其他的ViewController实现了UIGestureRecognizerDelegate协议里面的gestureRecognizerShouldBegin方法，也会执行识别到检测是否可以右滑返回
        return [self.topViewController performSelector:@selector(gestureRecognizerShouldBegin:) withObject:gestureRecognizer]?YES:NO;
    }
    //如果topViewController不能检测到这个方法默认开启右滑返回
    return YES;
}

@end
