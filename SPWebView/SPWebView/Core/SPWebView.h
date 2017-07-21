//
//  SPWebView.h
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

@class SPWebView;

typedef NS_ENUM(NSInteger, SPWebViewNavigationType) {
    SPWebViewNavigationTypeLinkClicked,
    SPWebViewNavigationTypeFormSubmitted,
    SPWebViewNavigationTypeBackForward,
    SPWebViewNavigationTypeReload,
    SPWebViewNavigationTypeFormResubmitted,
    SPWebViewNavigationTypeOther
};

@protocol SPWebViewDelegate <NSObject>
@optional
- (void)webViewDidStartLoad:(SPWebView *)webView;
- (void)webViewDidFinshLoad:(SPWebView *)webView;
- (void)webView:(SPWebView *)webView withError:(NSError *)error;
- (BOOL)webView:(SPWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(SPWebViewNavigationType)navigationType;

//NJKWebViewProgress
- (void)webView:(SPWebView *)webView updateProgress:(float)progress;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;
#endif

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

@interface SPWebView : UIView

/*! @abstract The web delegate. */
@property ( nonatomic, weak) id <SPWebViewDelegate> delegate;
@property ( nonatomic, readonly, copy) NSURL *URL;
@property ( nonatomic, readonly, strong) NSURLRequest *request;
@property ( nonatomic, readonly, copy) NSString *title;
@property ( nonatomic, readonly) UIView *webView;// defult is WKWebView ,WKWebView have't cache ,you can choose UIWebView before ViewDidLoad.
@property ( nonatomic, readonly) BOOL canGoBack;//web.canGoBack
@property ( nonatomic, readonly) BOOL canGoForward;//web.canGoForward
/*! @abstract   Allow Register NatvieHelper JavaScript
 if set No NatvieHelper will not register ,you can register on html,defult is Yes
 */
@property ( nonatomic, getter=isAllowNativeHelperJS) BOOL allowNativeHelperJS;

/****************************init**********************/

- ( instancetype)initWKWebView;
- ( instancetype)initWKWebViewWithFrame:(CGRect)frame;

- ( instancetype)initUIWebView; // If you want choose UIWebView
- ( instancetype)initUIWebViewWithFrame:(CGRect)frame;

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

/*! @abstract Sets the webpage contents and base URL.
 @param data The data to use as the contents of the webpage.
 @param MIMEType The MIME type of the data.
 @param textEncodingName The data's character encoding name.
 @param baseURL A URL that is used to resolve relative URLs within the document.
 */
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;

/*! @abstract Reloads the current page.
 */
- (void)reload;
- (void)stopLoading;
- (void)goBack;
- (void)goForward;

/****************************invokeJavaScript**********************/

- (void)invokeJavaScript:(NSString *)function;

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)(  id, NSError *error))completionHandler;

/****************************bundleForName**********************/

+ (NSBundle *)bundleForName:(NSString *)bundleName;

@end
