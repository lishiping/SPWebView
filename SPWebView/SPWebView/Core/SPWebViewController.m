//
//  SPWebViewController.m
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


#define SP_STATUSBAR_HEIGHT     ([[UIApplication sharedApplication] statusBarFrame].size.height)

#define SP_NAVIBAR_HEIGHT (self.navigationController.navigationBar.frame.size.height)

#import "SPWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface SPWebViewController ()<SPWebViewDelegate>

@property (nonatomic,strong)UIBarButtonItem* customBackBarItem;
@property (nonatomic,strong)UIBarButtonItem* closeButtonItem;

@property (nonatomic,strong)NJKWebViewProgressView *progressView;
@property (nonatomic,strong)NJKWebViewProgress *progressProxy;

@property (nonatomic, strong) SPWebView *webView;

@end

@implementation SPWebViewController

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
    _isUseWeChatStyle = YES;
    _useGoback = YES;
    _isHiddenProgressView = NO;
    _progressViewColor = [UIColor colorWithRed:119.0/255 green:228.0/255 blue:115.0/255 alpha:1];
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
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    
}

#pragma mark - initialize
- (void)initialize{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //如果是仿微信风格，则设置导航栏背景色为渐变图片，文字白色，状态栏文字白色
    if (_isUseWeChatStyle && ![self isNavigationHidden])
    {
        NSBundle *bundle = [SPWebView bundleForName:@"SPWebView"];
        NSString *url =  [NSBundle pathForResource:@"spnavbarperfect@2x" ofType:@"png" inDirectory:bundle.bundlePath];
        UIImage *image = [UIImage imageWithContentsOfFile:url];
        
        [self.navigationController.navigationBar setBackgroundImage:image
                                                      forBarMetrics:UIBarMetricsDefault];
        _titleColor = [UIColor whiteColor];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
    //如果没有设置微信风格，设置主题颜色
    if (_titleColor && ![self isNavigationHidden]) {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:_titleColor};
        self.navigationController.navigationBar.tintColor = _titleColor;
    }
    
    if (_barTintColor && ![self isNavigationHidden]) {
        
        [self.navigationController.navigationBar setBackgroundImage:nil
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.barTintColor = _barTintColor;
    }
    
    //是否使用返回goback风格
    if (_useGoback) {
        [self updateNavigationItems];
    }
    else
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationItem.hidesBackButton = YES;
        
        self.navigationItem.leftBarButtonItem = self.customBackBarItem;
    }
    
    [self.view addSubview:self.webView];
    [self.webView loadURL:_URL];
    
    if (!_isHiddenProgressView) {
        [self.webView addSubview:self.progressView];
        [self.webView bringSubviewToFront:self.progressView];
    }
}

#pragma mark - setter & getter method

-(void)setURL:(NSURL *)URL
{
    _URL = URL;
}

-(void)setProgressViewColor:(UIColor *)progressViewColor{
    _progressViewColor = progressViewColor;
    if (_progressView) {
        _progressView.progressBarView.backgroundColor = _progressViewColor;
    }
}

-(SPWebView*)webView
{
    if (!_webView) {
        
        CGFloat he =[self isNavigationHidden] ? self.view.frame.size.height-SP_STATUSBAR_HEIGHT : self.view.frame.size.height-(SP_STATUSBAR_HEIGHT+SP_NAVIBAR_HEIGHT);
        
        CGRect rect = CGRectMake(0, [self isNavigationHidden]?SP_STATUSBAR_HEIGHT:(SP_STATUSBAR_HEIGHT+SP_NAVIBAR_HEIGHT), self.view.frame.size.width,he);
        
        if (_useUIWebView) {
            _webView = [[SPWebView alloc]initUIWebViewWithFrame:rect];
        }else{
            _webView = [[SPWebView alloc]initWKWebViewWithFrame:rect];
        }
        _webView.delegate = self;
    }
    return _webView;
}

-(NJKWebViewProgressView*)progressView{
    if (!_progressView) {
        
        _progressView = [[NJKWebViewProgressView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 3)];
        if(_progressViewColor){
            _progressView.progressBarView.backgroundColor = _progressViewColor;
        }
    }
    return _progressView;
}

-(UIBarButtonItem*)customBackBarItem{
    if (!_customBackBarItem) {
        
        //从bundle读取icon
        NSBundle *bundle = [SPWebView bundleForName:@"SPWebView"];
        NSString *backItemurl =  [NSBundle pathForResource:@"spbackIconBlack@2x" ofType:@"png" inDirectory:bundle.bundlePath];
        NSString *backItemHLurl =  [NSBundle pathForResource:@"spbackIconBlack-hl@2x" ofType:@"png" inDirectory:bundle.bundlePath];
        
        //转为图片的时候忽略图片颜色
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

-(void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - WebViewDelegate

-(void)webView:(SPWebView *)webView updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
}

- (void)webViewDidStartLoad:(SPWebView *)webView{
    
}

- (void)webViewDidFinshLoad:(SPWebView *)webView{
    if (webView.title.length >0) {
        self.title = webView.title;
    }
}

- (void)webView:(SPWebView *)webView withError:(NSError *)error{
    
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
    //    self.navigationController.navigationBarHidden
    return self.navigationController.navigationBar.hidden;
}

@end
