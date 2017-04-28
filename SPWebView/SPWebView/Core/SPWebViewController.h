//
//  SPWebViewController.h
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//

//If you feel the WebView open source is of great help to you, please give the author some praise, recognition you give great encouragement, the author also hope you give the author other open source libraries some praise, the author will release better open source library for you again
//如果您感觉本开源WebView对您很有帮助，请给作者点个赞，您的认可给作者极大的鼓励，也希望您给作者其他的开源库点个赞，作者还会再发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData


#import <UIKit/UIKit.h>
#import "SPWebView.h"

@interface SPWebViewController : UIViewController

@property (nonatomic, strong) UIColor *titleColor;//titleColor,navigationBar.tintColor

@property (nonatomic,strong) UIColor* progressViewColor;

@property (nonatomic, readonly) SPWebView *webView;

@property (nonatomic, assign) BOOL isUseWeChatStyle; //Imitate WeChat style.defult is YES ,if you set NO you need self-define style

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
