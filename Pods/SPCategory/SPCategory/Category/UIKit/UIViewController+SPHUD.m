//
//  UIViewController+HUD.m
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



#import "UIViewController+SPHUD.h"
#import "UIImage+SPGIF.h"


// 使block在主线程中运行
#define sp_run_in_main_thread(block)    if ([NSThread isMainThread]) {(block);} else {dispatch_async(dispatch_get_main_queue(), ^{(block);});}

#define sp_color_rgb(rgbValue) [UIColor colorWith\
Red     :(rgbValue & 0xFF0000)     / (float)0xFF0000 \
green   :(rgbValue & 0xFF00)       / (float)0xFF00 \
blue    :(rgbValue & 0xFF)         / (float)0xFF \
alpha   :1.0]


#define hud_detailLabel_textColor [UIColor whiteColor]//文本颜色
#define hud_backgroundColor [UIColor whiteColor]//整体背景色
#define hud_bezelView_Color sp_color_rgb(0x1E1E1E)//hud块背景色
#define hud_detailLabel_font [UIFont systemFontOfSize:14]//文本字体



@implementation UIViewController (SPHUD)

#pragma mark - sp_showPrompt

-(void)sp_showToast:(NSString *)message
{
    [self sp_showPrompt:message];
}

- (void)sp_showPrompt:(NSString *)message;
{
    CGFloat time = 1.5;
    time += (message.length / 20.);
    time = MIN(time, 5);
    [self sp_showPrompt:message delayHide:time];
}

-(void)sp_showPrompt:(NSString *)message delayHide:(float)seconds
{
    [self sp_hideHUD];
    
    UIView *v = [self hudSuperView];
    sp_run_in_main_thread(showPrompt(v, message, seconds, YES));
}

- (void)sp_showPromptAddWindow:(NSString *)message
{
    [self sp_hideHUD];
    
    sp_run_in_main_thread(showPrompt([[UIApplication sharedApplication].delegate window], message, 2, YES));
}

#pragma mark - sp_showHUD

- (void)sp_showHUD
{
    [self sp_showHUD:nil animation:YES];
}

- (void)sp_showHUD:(NSString *)message
{
    [self sp_showHUD:message animation:YES];
}

- (void)sp_showHUD:(NSString *)message animation:(BOOL)animated
{
    UIView *v = [self hudSuperView];
    [self sp_showHUDInView:v message:message animation:animated];
}

- (void)sp_showHUDInView:(UIView *)superView message:(NSString *)message animation:(BOOL)animated
{
    [self sp_hideHUDInView:superView delay:0.0 animated:NO];
    sp_run_in_main_thread(showHUD(superView, message, 0, animated));
}

#pragma mark - sp_showHUDGIF

- (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
{
    [self sp_showHUDGIF_name:gifNameInBundleStr text:nil detailText:nil];
}

- (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
                      text:(NSString *)text
                detailText:(NSString *)detailText
{
    [self sp_showHUDGIF_name:gifNameInBundleStr text:text detailText:detailText delayHide:0.0f];
}

- (void)sp_showHUDGIF_name:(NSString *)gifNameInBundleStr
                      text:(NSString *)text
                detailText:(NSString *)detailText
                 delayHide:(float)seconds
{
    UIImage *image = [UIImage sp_animatedGIFNamed:gifNameInBundleStr];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    [self sp_showHUDCustomView:imageview text:text detailText:detailText delayHide:seconds];
}

- (void)sp_showHUDGIF_data:(NSData *)gifData
                      text:(NSString *)text
                detailText:(NSString *)detailText
{
    [self sp_showHUDGIF_data:gifData text:text detailText:detailText delayHide:0.0f];
}

- (void)sp_showHUDGIF_data:(NSData *)gifData
                      text:(NSString *)text
                detailText:(NSString *)detailText
                 delayHide:(float)seconds
{
    UIImage *image = [UIImage sp_animatedGIFWithData:gifData];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    [self sp_showHUDCustomView:imageview text:text detailText:detailText delayHide:seconds];
}

- (void)sp_showHUDCustomView:(UIView *)customV
{
    [self sp_showHUDCustomView:customV text:nil detailText:nil delayHide:0.0f];
}

- (void)sp_showHUDCustomView:(UIView *)customV text:(NSString *)text detailText:(NSString *)detailText
{
    [self sp_showHUDCustomView:customV text:text detailText:detailText delayHide:0.0f];
}

- (void)sp_showHUDCustomView:(UIView *)customV text:(NSString *)text detailText:(NSString *)detailText delayHide:(float)seconds
{
    UIView *v = [self hudSuperView];
    sp_run_in_main_thread(showCustomHUD(v, customV, text,detailText, seconds, YES));
}

- (void)sp_updateHUDMessage:(NSString *)message
{
    UIView *v = [self hudSuperView];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:v];
    if (hud)
    {
        hud.detailsLabel.text=message;
    }
    else
    {
        [self sp_showPrompt:message];
    }
}

#pragma mark - sp_showMBProgressHUD

- (void)sp_showMBProgressHUD:(NSString *)message mode:(MBProgressHUDMode)mode progress:(float)progress animation:(BOOL)animated
{
    [self sp_showMBProgressHUD:message mode:mode progress:progress animation:animated font:hud_detailLabel_font textColor:hud_detailLabel_textColor bezelViewColor:hud_bezelView_Color backgroundColor:hud_backgroundColor];
}

- (void)sp_showMBProgressHUD:(NSString *)message mode:(MBProgressHUDMode)mode progress:(float)progress animation:(BOOL)animated font:(UIFont *)font textColor:(UIColor *)textColor bezelViewColor:(UIColor *)bezelViewColor backgroundColor:(UIColor *)backgroundColor
{
    if (progress>0.999f) {
        [self sp_hideHUD];
        return;
    }
    UIView *superView = [self hudSuperView];
    sp_run_in_main_thread(showProgressHUD(superView, message, mode,progress, 0, animated,font,textColor,bezelViewColor,backgroundColor));
}


#pragma mark - hide

-(void)sp_hideHUD
{
    [self sp_hideHUD:NO];
}

- (void)sp_hideHUD:(BOOL)animated
{
    [self sp_hideHUD:NO delay:0.0f];
}

- (void)sp_hideHUD:(BOOL)animated delay:(float)seconds;
{
    UIView *v = [self hudSuperView];
    [self sp_hideHUDInView:v delay:seconds animated:animated];
}

- (void)sp_hideHUDInView:(UIView *)view delay:(float)seconds animated:(BOOL)animated
{
    sp_run_in_main_thread(hideHUD(view, seconds, animated));
}



#pragma mark - private

/**
 *  显示提示消息，白底黑字
 */
void showPrompt(UIView *superView, NSString *text, float showTime, BOOL animated)
{
    showSimpleProgressHUD(superView, text, MBProgressHUDModeText,0, showTime, animated);
}

/**
 *  显示 hud，带动画等待效果,白底黑字
 */
void showHUD(UIView *superView, NSString *text, float showTime, BOOL animated)
{
    showSimpleProgressHUD(superView, text, MBProgressHUDModeIndeterminate,0, showTime, animated);
}

/**
 *  显示 hud，带动画等待效果,自定义颜色
 */
void showSimpleProgressHUD(UIView *superView, NSString *text,MBProgressHUDMode mode,float progress, float showTime, BOOL animated)
{
    showProgressHUD(superView, text, mode,progress, showTime, animated,hud_detailLabel_font,hud_detailLabel_textColor,hud_bezelView_Color,hud_backgroundColor);
}

/**
 显示 ProgressHUD
 
 @param superView 父视图
 @param text 内容
 @param mode 模式
 @param showTime 显示时间
 @param animated 是否动画
 */
void showProgressHUD(UIView *superView, NSString *text,MBProgressHUDMode mode,float progress, float showTime, BOOL animated,UIFont *font,UIColor *textColor,UIColor *bezelViewColor,UIColor *backgroundColor)
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:superView];
    if (!hud)
    {
        hud = [MBProgressHUD showHUDAddedTo:superView animated:animated];
    }
    
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = mode;
    
    if (mode==MBProgressHUDModeDeterminate ||
        mode==MBProgressHUDModeDeterminateHorizontalBar ||
        mode==MBProgressHUDModeAnnularDeterminate)
    {
        hud.progress =progress;
    }
    hud.detailsLabel.text = text;
    
    if (font) {
        hud.detailsLabel.font = font;
    }
    if (textColor) {
        hud.detailsLabel.textColor = textColor;
    }
    if (bezelViewColor) {
        hud.bezelView.color = bezelViewColor;
    }
    if (backgroundColor) {
        hud.backgroundColor = backgroundColor;
    }
    
    if (showTime > 0.0f)
    {
        showTime = MIN(60, showTime);
        [hud hideAnimated:animated afterDelay:showTime];
    }
}

void showCustomHUD(UIView *superView, UIView *customView ,NSString *text, NSString *detailText,float showTime, BOOL animated)
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:superView];
    if (hud)
    {
        [hud removeFromSuperview];
    }
    hud = [MBProgressHUD showHUDAddedTo:superView animated:animated];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    
    if (text.length>0) {
        hud.label.text = text;
    }
    if (detailText.length>0) {
        hud.detailsLabel.text = detailText;
    }
    if (customView) {
        hud.customView = customView;
    }
    
    if (showTime > 0)
    {
        showTime = MIN(60, showTime);
        [hud hideAnimated:animated afterDelay:showTime];
    }
}

void hideHUD(UIView *superView, float delayTime, BOOL animated)
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:superView];
    if (!hud) {
        return;
    }
    hud.removeFromSuperViewOnHide = YES;
    
    delayTime = MIN(60, delayTime);
    [hud hideAnimated:animated afterDelay:delayTime];
}

- (UIView *)hudSuperView;
{
    UIView *ret;
    
    if ([self isKindOfClass:[UIViewController class]])
    {
        ret = self.view;
    }else if ([self isKindOfClass:[UIView class]])
    {
        ret = (UIView*)self;
    }
    
    if (!ret)
    {
        UIViewController *vc = (UIViewController *)self.navigationController.topViewController;
        ret = vc.view;
    }
    
    if (!ret)
    {
        ret = [[UIApplication sharedApplication].delegate window];
    }
    
    return (ret);
}

@end


