//
//  LSPWebViewController.m
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

#import "LSPWebViewController.h"
#import <SPMacro.h>
#import <SPFastPush.h>
#import <SPSafeData.h>
#import "NSDictionary+SPSafe.h"
#import "SPBundleTools.h"

//#import "DeviceTools.h"
#import "UIBarButtonItem+JItem.h"

@interface LSPWebViewController ()<LSPWebViewDelegate>

@property (nonatomic,strong)UIBarButtonItem* customBackBarItem;
@property (nonatomic,strong)UIBarButtonItem* closeButtonItem;

@property (nonatomic, strong) LSPWebView *webView;

@end

@implementation LSPWebViewController

#pragma mark - init

- (instancetype)initWithURLString:(NSString *)urlString
{
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithFilePath:(NSString *)urlString
{
    return [self initWithURL:[NSURL fileURLWithPath:urlString]];
}

-(instancetype)initWithURL:(NSURL *)URL
{
    self = [self init];
    _URL = URL;
    return self;
}

-(instancetype)init
{
    self = [super init];
    _useGoback = NO;
    _isHiddenProgressView = NO;
    _progressViewColor = SP_COLOR_HEX_STR(@"#43c6ac");
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.urlString.length>0) {
        self.URL = [NSURL URLWithString:self.urlString];
    }
    [self.view addSubview:self.webView];
    [self initialize];
    [self config_WKWebView_UserAgent];
    
    if (@available(iOS 12.2, *)) {
        [self loadURL];

    }
    /**WKWebView在ios12以下首次打开，需要等待的记录 */
    else if([[NSUserDefaults standardUserDefaults] boolForKey:@"WKWebView_Opened_Key"])
    {
        [self loadURL];
    }else{
//        [self sp_showHUD:@"加载中，请稍后"];
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"WKWebView_Opened_Key"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self sp_hideHUD];
            [self loadURL];
        });
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.webView registerFunction];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.webView removeFunction];
}

-(void)dealloc
{
    SP_SUPER_LOG(@"正常释放");
}

#pragma mark - initialize
- (void)initialize
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    //是否使用返回goback风格
    if (_useGoback) {
        [self updateNavigationItems];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = self.customBackBarItem;
    }
}

- (void)config_WKWebView_UserAgent
{
    SP_WEAK(self)
    [self invokeJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        if ([result isKindOfClass:NSString.class] && ((NSString*)result).length>0 &&[result containsString:@"Device"])
        {
            weak_self.webView.webView.customUserAgent = result;
        }
    }];
}
-(void)loadURL
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.URL];
    
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSMutableString *cookie = [[NSMutableString alloc] initWithString:@""];
//    for (NSHTTPCookie *coo in [cookieJar cookies]) {
//       [cookie appendFormat:@"%@=%@;",coo.name,coo.value];
//    }
//    if (cookie.sp_isString) {
//        [request addValue:cookie forHTTPHeaderField:@"Cookie"];
//    }
    // 3. 向Http Header中设置Cookie
    NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies];
    request.allHTTPHeaderFields = dict.copy;
    
    [self.webView loadRequest:request];
}
#pragma mark - setter & getter method

-(void)setURL:(NSURL *)URL
{
    _URL = URL;
}

-(void)setProgressViewColor:(UIColor *)progressViewColor{
    _progressViewColor = progressViewColor;
}

-(LSPWebView*)webView
{
    if (!_webView) {
        CGFloat y =[self isNavigationHidden] ? SP_STATUSBAR_HEIGHT : SP_NAVIBAR_STATUSBAR_HEIGHT;
        CGRect rect = CGRectMake(0,y, SP_SCREEN_WIDTH,SP_SCREEN_HEIGHT-y);
        _webView = [[LSPWebView alloc] initWKWebViewWithFrame:rect isShowProgressView:!self.isHiddenProgressView progressColor:self.progressViewColor];
        _webView.delegate = self;
    }
    return _webView;
}

-(UIBarButtonItem*)customBackBarItem
{
    if (!_customBackBarItem) {
        SP_WEAK_SELF
        UIImage *image = [SPBundleTools getPngImageBundle:@"SPWebView" imageName:@"spbackIconBlack"];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithImage:image color:UIColor.blackColor click:^(id object) {
            [weak_self customBackItemClicked];
        }];
    }
    return _customBackBarItem;
}

-(UIBarButtonItem*)closeButtonItem
{
    if (!_closeButtonItem) {
        UIImage *image = [SPBundleTools getPngImageBundle:@"SPWebView" imageName:@"delete"];
        _closeButtonItem = [[UIBarButtonItem alloc] initWithImage:image color:UIColor.blackColor click:^(id object) {
            SP_POP_TO_LAST_VC
        }];
    }
    return _closeButtonItem;
}

-(void)updateNavigationItems
{
    if (self.webView.canGoBack) {
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem,self.closeButtonItem] animated:NO];
    }else{
        self.navigationItem.leftBarButtonItem = self.customBackBarItem;
    }
}

#pragma mark - click event
-(void)customBackItemClicked
{
    if (self.webView.canGoBack && _useGoback)
    {
        [self.webView goBack];
        [self updateNavigationItems];
    }
    else
    {
        [self closeItemClicked];
    }
}

-(void)closeItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WebViewDelegate

-(BOOL)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
//    NSURL *url = navigationAction.request.URL;
//    if ([url.host isEqualToString:@"itunes.apple.com"]) {
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            SP_APP_OPEN_URL(url)
//            // 跳转之后会白屏，返回上一级
//            if ([self.webView canGoBack]) {
//                [self.webView goBack];
//            }
//            return NO;
//        }
//    }
    return YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if (webView.title.length >0) {
        self.title = webView.title;
    }
}
/**
 * @brief Register Invoke JavaScript observe（指定接收对象，当前设置为self，也可以指给其他对象，在其他对象中实现注册名称和注册名称的实现方法）
 */
- (NSObject *)registerJavaScriptHandler{
    return self;
}

- (NSArray <NSString *>*)registerJavascriptName{
    return nil;
}

#pragma mark - Public
- (void)callFromNative:(NSString *)method params:(NSDictionary*)params
{
    return [self callFromNative:method params:params completionHandler:nil];
}
- (void)callFromNative:(NSString *)method params:(NSDictionary*)params completionHandler:(void (^)( id, NSError * error))completionHandler
{
    if (method.length>0)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
        [dict setObject:method forKey:@"method"];
        NSString *paramstr = params.safe_toJSONString_UTF8;
        if (paramstr.length>0) {
            [dict setObject:paramstr forKey:@"params"];
        }
        NSString *jsString = [NSString stringWithFormat:@"callFromNative('%@')",dict.safe_toJSONString_UTF8];
        [self invokeJavaScript:jsString completionHandler:completionHandler];
    }
}

- (void)invokeJavaScript:(NSString *)function{
    [self.webView invokeJavaScript:function];
}

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler{
    [self.webView invokeJavaScript:function completionHandler:completionHandler];
}

#pragma makr Private
- (BOOL)isNavigationHidden
{
    return self.navigationController.navigationBar.hidden;
}

@end
