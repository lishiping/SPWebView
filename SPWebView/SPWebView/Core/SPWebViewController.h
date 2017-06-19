//
//  SPWebViewController.h
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//
//If you think this open source library is of great help to you, please open the URL to click the Star,your approbation can encourage me, the author will publish the better open source library for guys again
//如果您认为本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory


#import <UIKit/UIKit.h>
#import "SPWebView.h"

@interface SPWebViewController : UIViewController

@property (nonatomic, strong) UIColor *titleColor;//titleColor,navigationBar.tintColor

@property (nonatomic,strong) UIColor* progressViewColor;

@property (nonatomic, readonly) SPWebView *webView;

@property (nonatomic, assign) BOOL isUseWeChatStyle; //Imitate WeChat style.defult is YES ,if you set NO you need self-define style（默认仿微信风格）

@property (nonatomic, assign ,getter= isUseUIWebView) BOOL useUIWebView;// defult is NO ,if you set YES the webView is UIWebView

@property (nonatomic, assign) BOOL isHiddenProgressView; // defult is NO ,if you set Yes the progressBar will not show .

/**
 * @brief load remote URL（加载远端URL地址）
 */
- (instancetype)initWithURLString:(NSString *)urlString;

/**     
 * @brief load local html file（加载本地文件路径）
 */
- (instancetype)initWithFilePath:(NSString *)urlString;

- (instancetype)initWithURL:(NSURL *)URL;

/*************************JS to OC*************************/

/**
 * @brief Registered js calls OC method name（注册js调用OC的方法名称）
 * @return Subclasses need to return to the registration method names, as well as the method, so js data to the OC（子类需要返回注册的方法名称，以及方法实现，这样实现js数据传到OC）
 */
- (NSArray <NSString *>*)registerJavascriptName;

/****************************OC to JS invokeJavaScript**********************/

/**
 * @brief OC inject method to JS （OC 向JS注入方法）
 */
- (void)invokeJavaScript:(NSString *)function;

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler;
@end
