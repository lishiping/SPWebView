//
//  SPWebListDemo.h
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

#import "SPWebListDemo.h"
#import "SPWebVCDemo.h"
#import "SPWebView.h"

@interface SPWebListDemo ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *data;

@end

@implementation SPWebListDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = @[@"WKWebView Load URL ",
              @"UIWebView Load URL ",
              @"WkWebView Load File",
              @"UIWebView Load File"];
    
    [self tableView];
}

-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.frame;
         [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell description]];
    cell.textLabel.text = _data[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            
            //example: similar to SPWebVCDemo, inherit SPWebViewController, pay equal attention to write registerJavascriptName method, join registered JSname, and realization method of the registration
            //使用例子：类似于SPWebVCDemo，继承SPWebViewController，并重写registerJavascriptName方法，加入注册的JSName，并实现注册的方法
            SPWebVCDemo *web = [[SPWebVCDemo alloc]initWithURLString:@"https://github.com/lishiping"];
            [self.navigationController pushViewController:web animated:YES];
        } break;
            
        case 1:{
             SPWebVCDemo *web = [[SPWebVCDemo alloc]initWithURLString:@"https://www.xin.com"];
            web.useUIWebView = YES;
            [self.navigationController pushViewController:web animated:YES];
        } break;
            
        case 2:{
            
            NSBundle *bundle = [SPWebView bundleForName:@"SPWebView"];
            NSString *url =  [NSBundle pathForResource:@"WebViewDemo" ofType:@"html" inDirectory:bundle.bundlePath];
            SPWebVCDemo *web = [[SPWebVCDemo alloc]initWithFilePath:url];
            [self.navigationController pushViewController:web animated:YES];
        } break;
            
        case 3:{
            
            //example: similar to SPWebVCDemo, inherit SPWebViewController, pay equal attention to write registerJavascriptName method, join registered JSname, and realization method of the registration
            //使用例子：类似于SPWebVCDemo，继承SPWebViewController，并重写registerJavascriptName方法，加入注册的JSName，并实现注册的方法
            NSBundle *bundle = [SPWebView bundleForName:@"SPWebView"];
            NSString *url =  [NSBundle pathForResource:@"WebViewDemo" ofType:@"html" inDirectory:bundle.bundlePath];
            SPWebVCDemo *web = [[SPWebVCDemo alloc]initWithFilePath:url];
            web.useUIWebView = YES;
            web.isHiddenProgressView = YES;
            web.titleColor = [UIColor whiteColor];
            [self.navigationController pushViewController:web animated:YES];
        } break;
            
        default:
            break;
    }
}

@end
