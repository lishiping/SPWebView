//
//  UIViewController+SPErrorView.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//

#import "UIViewController+SPErrorView.h"
#import <objc/runtime.h>

static char spErrorViewKey;

@implementation UIViewController (SPErrorView)

-(void)sp_addspErrorView_block:(SPButtonClickedBlock)block
{
    [self sp_addspErrorView_image:nil title:@"点击重新加载" block:block];
}

#pragma mark - 带icon，标题的错误页
- (void)sp_addspErrorView_image:(UIImage *)image title:(NSString *)title block:(SPButtonClickedBlock)block
{
    for (UIView *view in self.view.subviews) {
        if ([view isMemberOfClass:[SPErrorView class]]) {
            return;
        }
    }
    if (!self.spErrorView)
    {
        if (!image) {
            NSString *pathComponent = [NSString stringWithFormat:@"%@.bundle", @"SPCategory"];
            NSString *bundlePath =[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:pathComponent];
            NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
            NSString *url =  [NSBundle pathForResource:@"reload_img@2x" ofType:@"png" inDirectory:bundle.bundlePath];
            image= [UIImage imageWithContentsOfFile:url];
        }
        
        self.spErrorView = [[SPErrorView alloc]initWithFrame:self.view.bounds
                                                       image:image
                                                       title:title
                                                       block:block];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:self.spErrorView];
            [self.view bringSubviewToFront:self.spErrorView];
        });
    }
}

#pragma mark - 带icon，标题，子标题，两个按钮及回调的错误页
-(void)sp_addspErrorView_image:(UIImage*)image
                         title:(NSString*)title
                      subtitle:(NSString*)subtitle
                 button1_title:(NSString*)button1_title
                 button2_title:(NSString*)button2_title
           button1_click_block:(SPButtonClickedBlock)button1_click_block
           button2_click_block:(SPButtonClickedBlock)button2_click_block
{
    for (UIView *view in self.view.subviews) {
        if ([view isMemberOfClass:[SPErrorView class]]) {
            return;
        }
    }
    if (!self.spErrorView)
    {
        if (!image) {
            NSString *pathComponent = [NSString stringWithFormat:@"%@.bundle", @"SPCategory"];
            NSString *bundlePath =[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:pathComponent];
            NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
            NSString *url =  [NSBundle pathForResource:@"reload_img@2x" ofType:@"png" inDirectory:bundle.bundlePath];
            image= [UIImage imageWithContentsOfFile:url];
        }
        
        self.spErrorView = [[SPErrorView alloc]initWithFrame:self.view.bounds
                                                       image:image
                                                       title:title
                                                    subtitle:subtitle button1_title:button1_title button2_title:button2_title button1_click_block:button1_click_block button2_click_block:button2_click_block];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:self.spErrorView];
            [self.view bringSubviewToFront:self.spErrorView];
        });
    }
}


-(void)sp_removespErrorView
{
    if (self.spErrorView) {
        [self.spErrorView removeFromSuperview];
        self.spErrorView = nil;
    }
}

-(void)setSpErrorView:(SPErrorView *)spErrorView{
    objc_setAssociatedObject(self, &spErrorViewKey, spErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(SPErrorView *)spErrorView
{
    return objc_getAssociatedObject(self, &spErrorViewKey);
}

@end
