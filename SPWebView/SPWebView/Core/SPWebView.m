//
//  SPWebView.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//

//  实现思路参照CHWebView,感谢作者Chausson开源,在作者原有基础上优化更新,使用NJKWebViewProgress,感谢作者开源

//If you think this open source library is of great help to you, please open the URL to click the Star,your approbation can encourage me, the author will publish the better open source library for guys again
//如果您认为本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory


#import "SPWebView.h"
#import "NJKWebViewProgress.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0

@interface SPWebView ()<UIWebViewDelegate,NJKWebViewProgressDelegate ,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

#else

@interface SPWebView ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

#endif

@end

@implementation SPWebView

#pragma mark - init &dealloc

- (instancetype)init
{
    self = [super init];
    if (self) {
        _webView = [[WKWebView alloc]initWithFrame:self.bounds configuration:[self configuretion]];
        [self initialize:(WKWebView *)_webView];
    }
    return self;
}

//默认使用WKWebView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:[self configuretion]];
        [self initialize:(WKWebView *)_webView];
    }
    return self;
}

- (instancetype)initWKWebView
{
    return [self init];
}

- (instancetype)initWKWebViewWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame];
}

- ( instancetype)initUIWebView
{
    self = [super init];
    if (self) {
        _webView = [[UIWebView alloc]initWithFrame:self.bounds];
        [self initializeUIWebView:(UIWebView *)_webView];
    }
    return self;
}

- ( instancetype)initUIWebViewWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _webView = [[UIWebView alloc]initWithFrame:self.bounds];
        [self initializeUIWebView:(UIWebView *)_webView];
    }
    return self;
}

-(void)dealloc{
    
}

#pragma mark - load method
- (void)loadURLString:(NSString *)urlString
{
    NSAssert(urlString.length, @"Error SPWebView loadURL: is not allow nil or empty");
    NSURLRequest *rquest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self loadRequest:rquest];
}

- (void)loadURL:(NSURL *)URL
{
    NSURLRequest *rquest = [NSURLRequest requestWithURL:URL];
    [self loadRequest:rquest];
}

/*! @abstract  requested URL.*/
- (void)loadRequest:(NSURLRequest *)request{
    
    //[(UIWebView*)_webView loadRequest:request];
    //[(WKWebView*)_webView loadRequest:request];
    _request = request;
    //使用此种方法的原因是先检测是否可以调用该方法，防止调用崩溃
    SEL selector = NSSelectorFromString(@"loadRequest:");
    if ([_webView respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            IMP imp = [_webView methodForSelector:selector];
            void (*func)(id, SEL, NSURLRequest *) = (void *)imp;
            func(_webView, selector,request);
        });
    }
}

/*! @abstract Sets the webpage contents and base URL.
 @param string The string to use as the contents of the webpage.
 @param baseURL A URL that is used to resolve relative URLs within the document.
 */
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL{
    SEL selector = NSSelectorFromString(@"loadHTMLString:baseURL:");
    if ([_webView respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            IMP imp = [_webView methodForSelector:selector];
            void (*func)(id, SEL, NSString *,NSURL *) = (void *)imp;
            func(_webView, selector,string,baseURL);
        });
    }
}

/*! @abstract Sets the webpage contents and base URL.
 @param data The data to use as the contents of the webpage.
 @param MIMEType The MIME type of the data.
 @param textEncodingName The data's character encoding name.
 @param baseURL A URL that is used to resolve relative URLs within the document.
 */
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL{
    SEL selector = NSSelectorFromString(@"loadData:MIMEType:textEncodingName:baseURL:");
    if ([_webView respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            IMP imp = [_webView methodForSelector:selector];
            void (*func)(id, SEL, NSData *,NSString *,NSString *,NSURL *) = (void *)imp;
            func(_webView, selector,data,MIMEType,textEncodingName,baseURL);
        });
    }
}

/*! @abstract Reloads the current page.
 */
- (void)reload{
    [self invokeName:@"reload"];
}

- (void)stopLoading{
    [self invokeName:@"stopLoading"];
}

- (void)goBack{
    [self invokeName:@"goBack"];
}

- (void)goForward{
    [self invokeName:@"goForward"];
}

- (BOOL)canGoBack{
    if ([_webView isKindOfClass:[WKWebView class]]) {
        WKWebView *wv = (WKWebView *)_webView;
        return wv.canGoBack;
    }else{
        UIWebView *wv = (UIWebView *)_webView;
        return wv.canGoBack;
    }
}

- (BOOL)canGoForward{
    if ([_webView isKindOfClass:[WKWebView class]]) {
        WKWebView *wv = (WKWebView *)_webView;
        return wv.canGoForward;
    }else{
        UIWebView *wv = (UIWebView *)_webView;
        return wv.canGoForward;
    }
}

- (void)invokeName:(NSString *)name{
    SEL selector = NSSelectorFromString(name);
    if ([_webView respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            IMP imp = [_webView methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(_webView, selector);
        });
    }
}

#pragma mark - invokeJavaScript
- (void)invokeJavaScript:(NSString *)function{
    [self invokeJavaScript:function completionHandler:nil];
}

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler{
    if ([_webView isKindOfClass:[WKWebView class]]) {
        WKWebView *wk = (WKWebView *)_webView;
        [wk evaluateJavaScript:function completionHandler:^(id a, NSError *e)
         {
             if (completionHandler) {
                 completionHandler(a,e);
             }
         }];
    }else{
        [self.context evaluateScript:function];
    }
}

#pragma mark - WKWebView Deleagte

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:( WKNavigation *)navigation{
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self];
    }
}

// 当内容开始返回时调用,当内容开始到达主框架时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    WKWebView *web = (WKWebView *)_webView;
    web.configuration.userContentController = [[WKUserContentController alloc] init];
    if (self.delegate && [self.delegate respondsToSelector:@selector(registerJavascriptName)]) {
        [[self.delegate registerJavascriptName] enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            [web.configuration.userContentController removeScriptMessageHandlerForName:name];
            [web.configuration.userContentController addScriptMessageHandler:self name:name];
        }];
    }
    if (self.isAllowNativeHelperJS){
        [self registerNativeHelperJS];
    }
    if ([self.delegate respondsToSelector:@selector(webViewDidFinshLoad:)]) {
        [self.delegate webViewDidFinshLoad:self];
    }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:( WKNavigation *)navigation withError:(NSError *)error{
    if ( [self.delegate respondsToSelector:@selector(webView:withError:)]) {
        [self.delegate webView:self withError:error];
    }
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    BOOL decision = YES;
    if ([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        decision = [self.delegate webView:self shouldStartLoadWithRequest:navigationAction.request navigationType:(SPWebViewNavigationType)navigationAction.navigationType];
    }
    if (!decision) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
//{
//    decisionHandler(WKNavigationResponsePolicyAllow);
//}

//// 接收到服务器跳转请求之后再执行
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
//{
//
//}
//1.创建一个新的WebVeiw
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;
//2.WebVeiw关闭（9.0中的新方法）
//- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);

//3.显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    //js 里面的alert实现，如果不实现，网页的alert函数无效
    UIViewController *vc = [self fetchVC];
    
    if (vc) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completionHandler) {
                completionHandler();
            }
        }]];
        [vc presentViewController:alert animated:YES completion:NULL];
    }
}

//4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    
}

//5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    //js 里面的alert实现，如果不实现，网页的alert函数无效
    UIViewController *vc = [self fetchVC];
    
    if (vc) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              completionHandler(YES);
                                                          }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction *action){
                                                              completionHandler(NO);
                                                          }]];
        
        [vc presentViewController:alertController animated:YES completion:NULL];
    }
}

//收到JS的回执脚本就会运行一次
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [self invokeIMPFunction:message.body name:message.name];
}

#pragma mark - UIWebView Delegate
//在发送请求之前，决定是否跳转,如果返回NO，代表不允许加载这个请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        return  [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:(SPWebViewNavigationType)navigationType];
    }else{
        return YES;
    }
}

// 页面开始加载时调用
- (void)webViewDidStartLoad:(UIWebView *)webView{
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self];
    }
}

// 页面加载完成之后调用
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([self.delegate respondsToSelector:@selector(webViewDidFinshLoad:)])
    {
        UIWebView *web = (UIWebView *)_webView;
        self.context=[web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        if([self.delegate respondsToSelector:@selector(registerJavascriptName)]){
            [[self.delegate registerJavascriptName] enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
                __weak typeof(self) weakSelf = self;
                self.context[name] = ^(id body){
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf invokeIMPFunction:body name:name];
                };
            }];
        }
        if (self.isAllowNativeHelperJS){
            [self registerNativeHelperJS];
        }
        
        [self.delegate webViewDidFinshLoad:self];
    }
}

// 页面加载失败时调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    if ( [self.delegate respondsToSelector:@selector(webView:withError:)]) {
        [self.delegate webView:self withError:error];
    }
}

#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if ([self.delegate respondsToSelector:@selector(webView:updateProgress:)]) {
        [self.delegate webView:self updateProgress:progress];
    }
}

#pragma mark - KVO 监听WKWebView
- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects:@"estimatedProgress", @"title", nil];
}

- (void)registerForKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [_webView addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        @try {
            [_webView removeObserver:self forKeyPath:keyPath];
        } @catch (NSException *exception) {
            NSLog(@"%d %s %@",__LINE__,__PRETTY_FUNCTION__,[exception description]);
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForWKWebView:) withObject:object waitUntilDone:NO];
    } else {
        [self updateUIForWKWebView:object];
    }
}

#pragma mark - Private

- (void)initialize:(WKWebView *)webView{
    webView.allowsBackForwardNavigationGestures =YES;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    _allowNativeHelperJS = YES;
    [self addSubview:webView];
    [self registerForKVO];
}

- (void)initializeUIWebView:(UIWebView *)webView{
    _progressProxy = [[NJKWebViewProgress alloc]init];
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    webView.delegate = _progressProxy;
    webView.backgroundColor = [UIColor whiteColor];
    _allowNativeHelperJS = YES;
    [self addSubview:webView];
}

- (UIViewController *)fetchVC{
    UIViewController *result = [UIApplication sharedApplication].keyWindow.rootViewController;
    return result;
}

- (void)registerNativeHelperJS{
    NSString *file = [[NSBundle mainBundle]pathForResource:@"spnativehelper" ofType:@"js"];
    if (file) {
        NSString *js = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
        [self invokeJavaScript:js];
    }else{
        NSURL *url = [[SPWebView bundleForName:@"SPWebView"] URLForResource:@"spnativehelper" withExtension:@"js"];
        NSString *js = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        [self invokeJavaScript:js];
    }
}

- (void)updateUIForWKWebView:(WKWebView *)web {
    
    float progress =web.estimatedProgress;
    if ([self.delegate respondsToSelector:@selector(webView:updateProgress:)]) {
        [self.delegate webView:self updateProgress:progress];
    }
}

- (void)invokeIMPFunction:(id)body name:(NSString *)name{
    NSObject *observe  = [self.delegate registerJavaScriptHandler];
    if (observe) {
        SEL selector;
        BOOL isParameter = YES;
        if ([body isKindOfClass:[NSString class]]) {
            isParameter = ![body isEqualToString:@""];
        }
        if ( isParameter && body) {
            selector = NSSelectorFromString([name stringByAppendingString:@":"]);
        }else{
            selector = NSSelectorFromString(name);
        }
        if ([observe respondsToSelector:selector]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                IMP imp = [observe methodForSelector:selector];
                if (body) {
                    void (*func)(id, SEL, id) = (void *)imp;
                    func(observe, selector,body);
                }else{
                    void (*func)(id, SEL) = (void *)imp;
                    func(observe, selector);
                }
            });
        }
    }
}

#pragma mark - Getter & Setter
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _webView.frame = self.bounds;
}

- (WKWebViewConfiguration *)configuretion{
    WKWebViewConfiguration *configuretion = [[WKWebViewConfiguration alloc] init];
    configuretion.preferences = [[WKPreferences alloc]init];
    configuretion.preferences.minimumFontSize = 10;
    configuretion.preferences.javaScriptEnabled = true;
    configuretion.processPool = [[WKProcessPool alloc]init];
    // 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开
    configuretion.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    return configuretion;
}

- (NSString *)title{
    if ([_webView isKindOfClass:[WKWebView class]]) {
        WKWebView *wk = (WKWebView *)_webView;
        return wk.title;
    }else{
        UIWebView *web = (UIWebView *)_webView;
        return [web stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}

- (NSURL *)URL{
    if ([_webView isKindOfClass:[WKWebView class]]) {
        WKWebView *wk = (WKWebView *)_webView;
        return wk.URL;
    }else{
        UIWebView *web = (UIWebView *)_webView;
        return web.request.URL;
    }
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    if ([_webView isKindOfClass:[WKWebView class]]) {
        [self unregisterFromKVO];
    }
}

+ (NSBundle *)bundleForName:(NSString *)bundleName{
    NSString *pathComponent = [NSString stringWithFormat:@"%@.bundle", bundleName];
    NSString *bundlePath =[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:pathComponent];
    NSBundle *customizedBundle = [NSBundle bundleWithPath:bundlePath];
    return customizedBundle;
}


@end
