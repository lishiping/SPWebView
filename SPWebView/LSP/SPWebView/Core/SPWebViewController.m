//
//  SPWebViewController.m
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

#import "SPWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface SPWebViewController ()<SPWebViewDelegate>

@property (nonatomic,strong)UIBarButtonItem* customBackBarItem;
@property (nonatomic,strong)UIBarButtonItem* closeButtonItem;

@property (nonatomic,strong)NJKWebViewProgressView *progressView;
@property (nonatomic,strong)NJKWebViewProgress *progressProxy;

@property (nonatomic, strong) SPWebView *webView;

@property (nonatomic ,assign) BOOL isFile;
@property (nonatomic ,strong) NSURLRequest *req;
@property (nonatomic ,assign) BOOL hiddenNavtionBar;
@end

@implementation SPWebViewController

#pragma mark - init
- (instancetype)initWithURLString:(NSString *)urlString
{
    if (self = [super init]) {
        _url = [NSURL URLWithString:urlString];
        _isHiddenProgressView = NO;
        _isUseWeChatStyle = YES;
        _isFile = NO;
        _progressViewColor = [UIColor colorWithRed:119.0/255 green:228.0/255 blue:115.0/255 alpha:1];
    }
    return self;
}

- (instancetype)initWithFilePath:(NSString *)urlString{
    if (self = [super init]) {
        _url = [NSURL fileURLWithPath:urlString];
        _isHiddenProgressView = NO;
        _isUseWeChatStyle = YES;
        _isFile = YES;
        _progressViewColor = [UIColor colorWithRed:119.0/255 green:228.0/255 blue:115.0/255 alpha:1];
        
    }
    return self;
}


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_isHiddenProgressView&&_progressView) {
        [_progressView removeFromSuperview];
    }
    //    self.navigationController.navigationBarHidden = [self isNavigationHidden];
    //    self.automaticallyAdjustsScrollViewInsets = ![self isNavigationHidden];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    
}

#pragma mark -
- (void)initialize{
    if([self isNavigationHidden]){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if (_isUseWeChatStyle && !self.navigationController.navigationBarHidden) {
        NSBundle *bundle = [SPWebView bundleForName:@"SPWebView"];
        NSString *url =  [NSBundle pathForResource:@"spnavbarperfect" ofType:@"png" inDirectory:bundle.bundlePath];
        UIImage *image = [UIImage imageWithContentsOfFile:url];
        
        [self.navigationController.navigationBar setBackgroundImage:image
                                                     forBarPosition:UIBarPositionAny
                                                         barMetrics:UIBarMetricsDefault];
        _titleColor = [UIColor whiteColor];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
    if (_titleColor && self.navigationController) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:_titleColor};
        self.navigationController.navigationBar.tintColor = _titleColor;
    }
    
    [self updateNavigationItems];
    
    [self.view addSubview:self.webView];
    [self.webView loadURL:_url];
    
    if (!_isHiddenProgressView) {
        [self.webView addSubview:self.progressView];
        [self.webView bringSubviewToFront:self.progressView];
    }
}

#pragma mark - setter & getter method
-(void)setProgressViewColor:(UIColor *)progressViewColor{
    _progressViewColor = progressViewColor;
    self.progressView.progressColor = progressViewColor;
}
- (NSURLRequest *)req{
    if (!_req) {
        _req = [NSURLRequest requestWithURL:self.url];
    }
    return _req;
}

-(SPWebView*)webView
{
    if (!_webView) {
        
        CGFloat he =[self isNavigationHidden]?self.view.frame.size.height:self.view.frame.size.height-64;
        CGRect rect = CGRectMake(0, 0 , self.view.frame.size.width,he);
        if (self.useUIWebView) {
            _webView = [[SPWebView alloc]initWithUIWebView:rect];
        }else{
            _webView = [[SPWebView alloc]initWithFrame:rect];
        }
        _webView.delegate = self;
    }
    return _webView;
}

-(NJKWebViewProgressView*)progressView{
    if (!_progressView) {
        
        _progressView = [[NJKWebViewProgressView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 3)];
        if(_progressViewColor){
            _progressView.progressColor = _progressViewColor;
        }
    }
    return _progressView;
}

-(UIBarButtonItem*)customBackBarItem{
    if (!_customBackBarItem) {
        
        NSBundle *bundle = [SPWebView bundleForName:@"SPWebView"];
        NSString *backItemurl =  [NSBundle pathForResource:@"spbackIconBlack@2x" ofType:@"png" inDirectory:bundle.bundlePath];
        NSString *backItemHLurl =  [NSBundle pathForResource:@"spbackIconBlack-hl@2x" ofType:@"png" inDirectory:bundle.bundlePath];
        
        UIImage* backItemImage = [[UIImage imageWithContentsOfFile:backItemurl] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage* backItemHlImage = [[UIImage imageWithContentsOfFile:backItemHLurl] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}

-(UIBarButtonItem*)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
    }
    return _closeButtonItem;
}

-(void)updateNavigationItems{
    if (self.webView.canGoBack) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationItem.hidesBackButton = YES;
        
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem,self.closeButtonItem] animated:NO];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationItem.hidesBackButton = YES;
        
        self.navigationItem.leftBarButtonItem = self.customBackBarItem;
    }
}

#pragma mark - click event
-(void)customBackItemClicked{
    if (self.webView.canGoBack)
    {
        [self.webView goBack];
        [self updateNavigationItems];
    }
    else
    {
        [self closeItemClicked];
    }
}

-(void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - WebViewDelegate

-(void)webView:(SPWebView *)webView updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
}

- (void)webView:(SPWebView *)webView withError:(NSError *)error{
    
}

- (void)webViewDidFinshLoad:(SPWebView *)webView{
    if (webView.title.length >0) {
        self.title = webView.title;
    }
}

- (void)webViewDidStartLoad:(SPWebView *)webView{
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(completionHandler){
            completionHandler();
        }
    }]];
    if (self) {
        [self presentViewController:alert animated:YES completion:NULL];
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

- (void)invokeJavaScript:(NSString *)function{
    [self.webView invokeJavaScript:function];
}

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler{
    [self.webView invokeJavaScript:function completionHandler:completionHandler];
}

#pragma makr Private
- (BOOL)isNavigationHidden{
    return self.navigationController.navigationBar.hidden;
//    return !self.navigationController
//    || !self.navigationController.navigationBar.isTranslucent
//    || !self.navigationController.navigationBar;
}


@end
