//
//  UIViewController+LSPErrorView.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//

#import "UIViewController+LSPErrorView.h"
#import <objc/runtime.h>
static char spErrorViewKey;

@implementation UIViewController (SPErrorView)



- (void)addspErrorViewWithTitle:(NSString *)title
{
    if (!self.spErrorView) {
        
        self.spErrorView = [[LSPErrorView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        self.spErrorView.backgroundColor = [UIColor whiteColor];
        self.spErrorView.titleLabel.text = title?:@"点击重新加载";
        [self.view addSubview:self.spErrorView];
        [self.view bringSubviewToFront:self.spErrorView];
        //实现下面的方法，点击回调重新刷新数据
        //        _var_weakSelf;
        //        spErrorView.tapBlock = ^(void){
        ////            [weakSelf queryListData];
        //        };
    }
}

-(void)removespErrorView
{
    if (self.spErrorView) {
        [self.spErrorView removeFromSuperview];
        self.spErrorView = nil;
    }
}

-(void)setSpErrorView:(LSPErrorView *)spErrorView{
    objc_setAssociatedObject(self, &spErrorViewKey, spErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(LSPErrorView *)spErrorView
{
    return objc_getAssociatedObject(self, &spErrorViewKey);
}




@end
