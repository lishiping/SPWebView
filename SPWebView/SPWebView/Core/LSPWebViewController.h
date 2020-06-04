//
//  LSPWebViewController.h
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
#import "LSPWebView.h"

@interface LSPWebViewController : UIViewController

@property (nonatomic, readonly) LSPWebView *webView;
@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, copy) NSString *urlString;//要加载的url地址字符串
@property (nonatomic,strong) UIColor* progressViewColor;//进度条颜色
@property (nonatomic, assign) BOOL useGoback;// (默认YES，当YES的时候，已经进入多层页面点击返回按钮类似仿微信，先执行webview的goBack方法返回到上一个页面，到最后一层再pop，如果设置为NO，则直接执行导航控制器的pop方法)

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

- (void)callFromNative:(NSString *)method params:(NSDictionary*)params;
/// 原生调用JS的方法，方法名和参数
/// @param method 方法名字符串
/// @param params 字典传参数
/// @param completionHandler 是否调用成功的回调方法
- (void)callFromNative:(NSString *)method params:(NSDictionary*)params completionHandler:(void (^)( id, NSError * error))completionHandler;
/*
 * @brief OC inject method to JS （OC 向JS注入方法）
 */
- (void)invokeJavaScript:(NSString *)function;
- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler;

@end
