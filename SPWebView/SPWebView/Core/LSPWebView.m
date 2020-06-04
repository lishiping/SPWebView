//
//  LSPWebView.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//

//  实现思路参照CHWebView,感谢作者Chausson开源,在作者原有基础上优化更新,使用NJKWebViewProgress

//If you think this open source library is of great help to you, please open the URL to click the Star,your approbation can encourage me, the author will publish the better open source library for guys again
//如果您认为本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory

//----------------------screen size-------------------------
//----------------------屏幕尺寸-------------------------

#define LSP_SCREEN_WIDTH      ([UIScreen mainScreen].bounds.size.width)

#define LSP_SCREEN_HEIGHT     ([UIScreen mainScreen].bounds.size.height)

#if DEBUG

#define SP_LOG(...)                 NSLog(__VA_ARGS__);

#else


#define SP_LOG(...)

#endif


#import "LSPWebView.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <SPMacro.h>
#import <SPFastPush.h>
#import <MJExtension.h>

static NSString *userAgentString;

@interface LSPWebView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property ( nonatomic, strong) WKWebView *instanceWebView;

@end

@implementation LSPWebView

#pragma mark - init &dealloc

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

+(WKWebView*)creatWebviewWithUserAgent:(NSString*)userAgent
{
   return [[self sharedManager] creatWebview_userAgent:userAgent];
}

-(WKWebView*)creatWebview_userAgent:(NSString*)userAgent
{
    if (self.instanceWebView) {
        [self.class configCookieWith:self.instanceWebView.configuration];
        userAgentString = userAgent;
        [self.class config_WKWebView:self.instanceWebView userAgent:userAgent];
        return self.instanceWebView;
    }
    
    WKWebView *wkwebview =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, LSP_SCREEN_WIDTH, LSP_SCREEN_HEIGHT) configuration:[self.class configuration]];
    self.instanceWebView = wkwebview;
    userAgentString = userAgent;
    [self.class config_WKWebView:wkwebview userAgent:userAgent];
    return wkwebview;
}

+(WKWebView*)config_WKWebView:(WKWebView*)wkwebview userAgent:(NSString*)userAgent
{
    SP_WEAK(wkwebview);

    [wkwebview evaluateJavaScript:@"navigator.userAgent" completionHandler:^(NSString *result, NSError *error) {
        if (result.length>0)
        {
            NSMutableString *mStr = [NSMutableString stringWithString:result];
            if (![result containsString:@"Device"] && userAgent.length>0) {
                [mStr appendString:[NSString stringWithFormat:@";%@",userAgent]];
               NSDictionary *dictionary = @{@"UserAgent":mStr};
                //写入到本地序列化，可能会影响其他浏览器框架
               [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
               [[NSUserDefaults standardUserDefaults] synchronize];
            }
            weak_wkwebview.customUserAgent = mStr;
        }else if(userAgent.length>0)
        {
            NSMutableString *mStr = [NSMutableString stringWithString:userAgent];
            wkwebview.customUserAgent = mStr;
        }
    }];
    return wkwebview;
}

- (instancetype)initWKWebViewWithFrame:(CGRect)frame isShowProgressView:(BOOL)isShowProgressView progressColor:(UIColor*)progressColor
{
    self = [super initWithFrame:frame];
    _webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:[self.class configuration]];
    [self.class config_WKWebView:_webView userAgent:userAgentString];
    _isShowProgressView = isShowProgressView;
    _progressColor = progressColor;
    [self initialize:_webView];
    return self;
}

-(void)dealloc
{
    [self unregisterFromKVO];
    SP_LOG(@"LSPWebView正常释放");
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
- (void)loadRequest:(NSURLRequest *)request
{
    _request = request;
    //使用此种方法的原因是先检测是否可以调用该方法，防止调用崩溃
    SEL selector = NSSelectorFromString(@"loadRequest:");
    if ([_webView respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            IMP imp = [self->_webView methodForSelector:selector];
            void (*func)(id, SEL, NSURLRequest *) = (void *)imp;
            func(self->_webView, selector,request);
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
            IMP imp = [self->_webView methodForSelector:selector];
            void (*func)(id, SEL, NSString *,NSURL *) = (void *)imp;
            func(self->_webView, selector,string,baseURL);
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

- (BOOL)canGoBack
{
    WKWebView *wv = (WKWebView *)_webView;
    return wv.canGoBack;
}

- (BOOL)canGoForward
{
    WKWebView *wv = (WKWebView *)_webView;
    return wv.canGoForward;
}

- (void)invokeName:(NSString *)name{
    SEL selector = NSSelectorFromString(name);
    if ([_webView respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            IMP imp = [self->_webView methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self->_webView, selector);
        });
    }
}

#pragma mark - invokeJavaScript
- (void)invokeJavaScript:(NSString *)function{
    [self invokeJavaScript:function completionHandler:nil];
}

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler
{
    if ([_webView isKindOfClass:[WKWebView class]]) {
        WKWebView *wk = (WKWebView *)_webView;
        [wk evaluateJavaScript:function completionHandler:^(id a, NSError *e)
         {
             if (completionHandler) {
                 completionHandler(a,e);
             }
         }];
    }
}

#pragma mark - WKWebView Deleagte

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:( WKNavigation *)navigation
{
    if ([self.delegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)]) {
        [self.delegate webView:webView didStartProvisionalNavigation:navigation];
    }
}
// 4 开始获取到网页内容时返回
// 当内容开始返回时调用,当内容开始到达主框架时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}

// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    //本地的cookie再次加入，给前端
    NSMutableDictionary *cookieDict = [NSMutableDictionary dictionary];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
   for (NSHTTPCookie *cookie in [cookieJar cookies]) { // 先将cookie去重，再拼接
       [cookieDict setObject:cookie.value forKey:cookie.name];
   }
   NSMutableString *cookie = [[NSMutableString alloc] init];
   for (NSString *key in cookieDict) { // 此处需要主要注意【格式】
       [cookie appendFormat:@"document.cookie = '%@=%@';\n",key,cookieDict[key]];
   }
    [self invokeJavaScript:cookie completionHandler:^(id result, NSError *error) {}];
    
    if (self.isAllowNativeHelperJS){
        [self registerNativeHelperJS];
    }
    
    [self registerFunction];
    
    
    
    if ([self.delegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [self.delegate webView:webView didFinishNavigation:navigation];
    }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:( WKNavigation *)navigation withError:(NSError *)error
{
    if ( [self.delegate respondsToSelector:@selector(webView:didFailNavigation:withError:)]) {
        [self.delegate webView:webView didFailNavigation:navigation withError:error];
    }
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    BOOL decision = YES;
    if ([self.delegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        decision = [self.delegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    }
    if (decision) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

// 3 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //接收前端的cookie，缓存到本地
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:response.allHeaderFields forURL:response.URL];
   //读取wkwebview中的cookie
    for (NSHTTPCookie *cookie in cookies) {
       [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}

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
//此方法作为js的alert方法接口的实现，默认弹出窗口应该只有提示信息及一个确认按钮，当然可以添加更多按钮以及其他内容，但是并不会起到什么作用
//点击确认按钮的相应事件需要执行completionHandler，这样js才能继续执行
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    //js 里面的alert实现，如果不实现，网页的alert函数无效
    UIViewController *vc = SP_GET_TOP_VC;
    if (vc) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completionHandler) {
                completionHandler();
            }
        }]];
        [vc presentViewController:alert animated:YES completion:NULL];
    }
}

//4.弹出一个输入框（与JS交互的）
// prompt
//作为js中prompt接口的实现，默认需要有一个输入框一个按钮，点击确认按钮回传输入值
//当然可以添加多个按钮以及多个输入框，不过completionHandler只有一个参数，如果有多个输入框，需要将多个输入框中的值通过某种方式拼接成一个字符串回传，js接收到之后再做处理
//参数 prompt 为 prompt(<message>, <defaultValue>);中的<message>
//参数defaultText 为 prompt(<message>, <defaultValue>);中的 <defaultValue>
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert]; [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [SP_GET_TOP_VC presentViewController:alertController animated:YES completion:nil];
}

//5.显示一个确认框（JS的）
// confirm
//作为js中confirm接口的实现，需要有提示信息以及两个相应事件， 确认及取消，并且在completionHandler中回传相应结果，确认返回YES， 取消返回NO
//参数 message为  js 方法 confirm(<message>) 中的<message>
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    //js 里面的alert实现，如果不实现，网页的alert函数无效
    UIViewController *vc = SP_GET_TOP_VC;
    
    if (vc) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                 message:message?:@""
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确认"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              completionHandler(YES);
                                                          }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
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
    
    if (self.isShowProgressView) {
        [self addSubview:self.progressView];
    }
    [self registerForKVO];
}

- (UIViewController *)fetchVC
{
    UIViewController *result = [UIApplication sharedApplication].keyWindow.rootViewController;
    return result;
}
- (void)registerFunction
{
    WKUserContentController *userContentController = _webView.configuration.userContentController?:[WKUserContentController new];
    if (self.delegate && [self.delegate respondsToSelector:@selector(registerJavascriptName)]) {
        [[self.delegate registerJavascriptName] enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            [userContentController removeScriptMessageHandlerForName:name];
            [userContentController addScriptMessageHandler:self name:name];
        }];
    }
    _webView.configuration.userContentController = userContentController;
}

- (void)removeFunction
{
    WKUserContentController *userContentController = _webView.configuration.userContentController;
    if (self.delegate && [self.delegate respondsToSelector:@selector(registerJavascriptName)]) {
        [[self.delegate registerJavascriptName] enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            [userContentController removeScriptMessageHandlerForName:name];
        }];
    }
}

- (void)registerNativeHelperJS
{
    NSString *file = [[NSBundle mainBundle]pathForResource:@"spnativehelper" ofType:@"js"];
    if (file) {
        NSString *js = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
        [self invokeJavaScript:js];
    }
    else{
        NSURL *url = [[LSPWebView bundleForName:@"SPWebView"] URLForResource:@"spnativehelper" withExtension:@"js"];
        NSString *js = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        [self invokeJavaScript:js];
    }
}

- (void)updateUIForWKWebView:(WKWebView *)web
{
    float progress =web.estimatedProgress;
    if (self.progressView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = progress > self.progressView.progress;
        [self.progressView setProgress:progress animated:animated];
        
        if (progress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(webView:updateProgress:)]) {
        [self.delegate webView:web updateProgress:progress];
    }
}

- (void)invokeIMPFunction:(id)body name:(NSString *)name{
    NSObject *observe  = [self.delegate registerJavaScriptHandler];
    if (observe) {
        SEL selector;
        BOOL isParameter = YES;
        NSDictionary *dic = nil;
        if ([body isKindOfClass:[NSString class]]) {
            isParameter = ![body isEqualToString:@""];
            dic = [body mj_JSONObject];
        }
        if (isParameter && body) {
            selector = NSSelectorFromString([name stringByAppendingString:@":"]);
        }else{
            selector = NSSelectorFromString(name);
        }
        if ([observe respondsToSelector:selector]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                IMP imp = [observe methodForSelector:selector];
                if (dic) {
                    void (*func)(id, SEL, id) = (void *)imp;
                    func(observe, selector,dic);
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

+ (WKWebViewConfiguration *)configuration
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = [[WKPreferences alloc]init];
    configuration.preferences.minimumFontSize = 10;
    configuration.preferences.javaScriptEnabled = true;
    // 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.allowsInlineMediaPlayback = YES;
    configuration.processPool = [self.class wkProcessPool];
    [self configCookieWith:configuration];
    return configuration;
}

+(void)configCookieWith:(WKWebViewConfiguration *)configuration
{
    if (!configuration) {
        return;
    }
    
    WKUserContentController *userContentController = configuration.userContentController?:[[WKUserContentController alloc] init];
    configuration.userContentController = userContentController;
    
   NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
   for (NSHTTPCookie *cookie in cookies) {
       NSString *cookieStr = [NSString stringWithFormat:@"document.cookie='%@=%@'",cookie.name,cookie.value];
       WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:cookieStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
       [userContentController addUserScript:cookieScript];
   }

   if (@available(iOS 11.0, *)) {
       WKHTTPCookieStore *cookieStroe = configuration.websiteDataStore.httpCookieStore;
       for (NSHTTPCookie *cookie in cookies) {
           [cookieStroe setCookie:cookie completionHandler:^{
           }];
       }
   } else {
       // Fallback on earlier versions
   }
}

-(UIProgressView*)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, self.bounds.size.width, 2);
        [_progressView setTrackTintColor:[UIColor clearColor]];
        _progressView.progressTintColor = self.progressColor;
        _progressView.backgroundColor = [UIColor clearColor];
    }
    return _progressView;
}

- (NSString *)title{
    WKWebView *wk = (WKWebView *)_webView;
    return wk.title;
}

- (NSURL *)URL{
    WKWebView *wk = (WKWebView *)_webView;
    return wk.URL;
}

+(WKProcessPool*)wkProcessPool
{
    static dispatch_once_t once;
    static WKProcessPool * __singleton__;
    dispatch_once( &once, ^{
        __singleton__ = [[WKProcessPool alloc] init];
    });
    return __singleton__;
}
- (void)removeFromSuperview{
    [super removeFromSuperview];
}

+ (NSBundle *)bundleForName:(NSString *)bundleName{
    NSString *pathComponent = [NSString stringWithFormat:@"%@.bundle", bundleName];
    NSString *bundlePath =[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:pathComponent];
    NSBundle *customizedBundle = [NSBundle bundleWithPath:bundlePath];
    return customizedBundle;
}


@end
