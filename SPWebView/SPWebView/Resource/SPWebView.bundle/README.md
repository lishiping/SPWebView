
//  实现思路参照CHWebView,感谢作者Chausson开源,在作者原有基础上优化更新,使用NJKWebViewProgress,感谢作者开源

# SPWebView

SPWebView is a code implementation based on OC WebView lightweight components, the UIWebView and WKWebView API is encapsulated into a unified class to use, and at the time of loading web pages provide a progress bar, at the same time, simplify the JS and OC call each other and the way to transfer data.On the basis of the author CHWebView increased imitation WeChat interface

SPWebView 是一个基于OC代码实现的WebView轻量级组件,将UIWebView和WKWebView的API封装成统一的类去使用,并且在加载网页的时候提供进度条,同时简化JS与OC互相调用及传递数据的方式。在原作者CHWebView的基础上增加了仿微信界面

![image](https://github.com/lishiping/SPWebView/blob/master/SPWebView/Resource/WebView.gif)

# Features(功能)
* You can use UIWebView or WKWebView as usual.
* You can load local resource file in your project more than remote url.
* JavaScript call native method  just coding in a line .
* Support CHWebViewController to load web.

* 自如的切换WKWebView以及UIWebView的使用
* 提供了网页加载进度条仿微信
* 利用一行代码实现JS与OC在iOS平台的交互
* 提供基类控制器方便快捷的加载网页

# 安装
You can download zip and drag SPWebView File in your project,also you can install with pod.

目前支持POD安装,或者可以实现下载project将SPWebView文件夹拖入你的工程中
``` bash
pod 'SPWebView'
```

# Requirements(要求)
* iOS 8.0+, 

# SPWebView init初始化
``` obj-c
    SPWebView *webView = [[SPWebView alloc]initWithFrame:rect];
    [webView loadRequest:self.request];
    webView.delegate = self;
    [self.view addSubview:webView];

```
## If you want change UIWebView(如果你想使用UIWebView,调用一下方法)
``` obj-c
- ( instancetype)initWithUIWebView; 
- ( instancetype)initWithUIWebView:(CGRect)frame;

```

# Also you can use SPWebViewController(也可以通过SPWebViewController初始化)
``` obj-c
- (instancetype)initWithURLString:(NSString *)urlString;

- (instancetype)initWithFilePath:(NSString *)urlString;

```
# JS invoke OC Code (JS调用OC代码)
## OC代码的实现,继承SPWebViewController则只需要实现注册名称和注册接收方法的实现。
``` obj-c
- (NSArray<NSString *> *)registerJavascriptName{
    return @[@"fetchMessage",@"showJSData"];
}

- (void)fetchMessage:(NSDictionary *)dic{
}

- (void)showJSData:(NSDictionary *)dic{
}
```
## Html can found window.NativeBridge object .
window.NativeBridge({f},{j})
@parameter f is native method name maybe it's named show or something else,you can defind it.
@parameter j is parameter used by method.

JS代码的实现,在js的函数中通过使用NativeBridge这样一个对象(web加载完之后自动注入)给Native发送消息,NativeBridge({name},{parameter})name是指注册函数名,parameter是指传入的参数.
``` javascript
   function nativeFounction() {
       var obj = { 'message' : 'Hello, JS!', 'numbers' : [ 1, 2, 3 ] };
       window.NativeBridge('fetchMessage',obj)
   }
    function showUIFuction(){
       window.NativeBridge('show')
    }
```
# OC Call JavaScript(OC调用JS)
``` obj-c
- (void)invokeJavaScript:(NSString *)function;

- (void)invokeJavaScript:(NSString *)function completionHandler:(void (^)( id, NSError * error))completionHandler;
```

# SPWebView Design(SPWebView设计图)

<img src="https://github.com/lishiping/SPWebView/blob/master/SPWebView/Resource/CHWebView.png"  title="SPWebView设计图">

# author blog Address(本作者博客地址)
https://github.com/lishiping/SPWebView

# Correlation Link(原作者博客地址)
http://chausson.github.io/2016/08/09/UIWebView%E4%B8%8EWKWebView/
