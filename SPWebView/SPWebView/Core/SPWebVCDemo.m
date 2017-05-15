//
//  SPWebVCDemo.m
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


#import "SPWebVCDemo.h"

@interface SPWebVCDemo ()

@end

@implementation SPWebVCDemo


- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSBundle *bundle = [SPWebView bundleForName:@"SPWebView"];
    NSString *url =  [NSBundle pathForResource:@"sppointIcon@2x" ofType:@"png" inDirectory:bundle.bundlePath];
    UIImage *image = [UIImage imageWithContentsOfFile:url];

    UIButton *callJS = [UIButton buttonWithType:UIButtonTypeCustom];
    callJS.frame = CGRectMake(0, 0, 22, 44);
    [callJS setImage:image forState:UIControlStateNormal];
    [callJS addTarget:self action:@selector(callJS) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:callJS];
    self.navigationItem.rightBarButtonItem = right;
}

#pragma mark -
- (void)callJS{
    //OC 调用JS代码，OC以字符串的形式向JS注入JS方法
    [self invokeJavaScript:@"callFromOC('I am iOS,OC invoke JS')"];
    
//    [self.webView loadURLString:@"https://www.baidu.com"];
//    [self.webView reload];
//    [self.webView goBack];
}

//JS invoke OC Code (JS调用OC代码)
//OC代码的实现,继承SPWebViewController则只需要实现注册名称和注册接收方法的实现。
/****************************JS invoke OC**********************/

- (NSArray<NSString *> *)registerJavascriptName{
    return @[@"fetchMessage",@"showJSData"];
}
//fetchMessage 要与上面数组返回字符串名字对应
- (void)fetchMessage:(NSDictionary *)dic{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"I got message from js about =%@",dic] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)showJSData{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"Show Function"] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

/****************************JS invoke OC**********************/


@end
