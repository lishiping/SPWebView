//
//  LSPWebView.h
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
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#import <WebKit/WebKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@protocol LSPWebViewDelegate <NSObject>
@optional
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error;
- (BOOL)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

//进度的代理方法
- (void)webView:(WKWebView *)webView updateProgress:(float)progress;

/**
 * @brief Register JavascriptName
 * @return need Pre-register names array
 */
- (NSArray<NSString *>*)registerJavascriptName;

/**
 * @brief Register Invoke JavaScript observe
 */
- (NSObject *)registerJavaScriptHandler;

@end

@interface LSPWebView : UIView

/*! @abstract The web delegate. */
@property ( nonatomic, weak) id <LSPWebViewDelegate> delegate;
@property ( nonatomic, readonly, copy) NSURL * URL;
@property ( nonatomic, readonly, strong) NSURLRequest * request;
@property ( nonatomic, readonly, copy) NSString * title;
@property ( nonatomic, readonly) WKWebView *webView;
@property ( nonatomic, readonly) BOOL canGoBack;//web.canGoBack
@property ( nonatomic, readonly) BOOL canGoForward;//web.canGoForward
/*! @abstract   Allow Register NatvieHelper JavaScript
 if set No NatvieHelper will not register ,you can register on html,defult is Yes
 */
@property ( nonatomic, getter=isAllowNativeHelperJS) BOOL allowNativeHelperJS;

@property ( nonatomic, assign) BOOL isShowProgressView;
@property ( nonatomic, strong) UIColor *progressColor;
@property ( nonatomic, strong) UIProgressView *progressView;

/****************************init**********************/


/// 在appdelegate的didfinishlaunch里面加入类方法可以提前设置cookie和UA
+(WKWebView*)creatWebviewWithUserAgent:(NSString*)userAgent;

- (instancetype)initWKWebViewWithFrame:(CGRect)frame isShowProgressView:(BOOL)isShowProgressView progressColor:(UIColor*)progressColor;

/****************************load**********************/
/*! @abstract  requested urlString.*/
- (void)loadURLString:(NSString *)urlString;
/*! @abstract  requested URL.*/
- (void)loadURL:(NSURL *)URL;
/*! @abstract  requested URL. map NSURLRequest*/
- (void)loadRequest:(NSURLRequest *)request;

/*! @abstract Sets the webpage contents and base URL.
 @param string The string to use as the contents of the webpage.
 @param baseURL A URL that is used to resolve relative URLs within the document.
 */
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

/*! @abstract Reloads the current page.
 */
- (void)reload;
- (void)stopLoading;
- (void)goBack;
- (void)goForward;

/****************************viewcontroller里面要成对的注册和移除对于JS的注册函数**********************/
/// 注册函数
- (void)registerFunction;
/// 移除函数
- (void)removeFunction;

/****************************invokeJavaScript**********************/

- (void)invokeJavaScript:(NSString *)function;

- (void)invokeJavaScript:(NSString *)function completionHandler:(nullable void (^)(  id, NSError *error))completionHandler;

/****************************bundleForName**********************/

+ (NSBundle *)bundleForName:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
