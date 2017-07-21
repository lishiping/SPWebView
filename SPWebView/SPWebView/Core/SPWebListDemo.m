//
//  SPWebListDemo.h
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
    
//    [self.navigationController setNavigationBarHidden:YES];
    
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
            
            //通常在使用的时候继承SPWebViewController，不要直接使用SPWebViewController，直接使用也不建议修复，能控制的接口及参数已经公开了
            
            //example: similar to SPWebVCDemo, inherit SPWebViewController, pay equal attention to write registerJavascriptName method, join registered JSname, and realization method of the registration
            //使用例子：类似于SPWebVCDemo，继承SPWebViewController，并重写registerJavascriptName方法，加入注册的JSName，并实现注册的方法
            SPWebVCDemo *web = [[SPWebVCDemo alloc]initWithURLString:@"https://github.com/lishiping"];
            [self.navigationController pushViewController:web animated:YES];
        } break;
            
        case 1:{
             SPWebVCDemo *web = [[SPWebVCDemo alloc]initWithURLString:@"https://www.baidu.com"];
            web.useUIWebView = YES;
            web.isUseWeChatStyle = NO;
            web.titleColor = [UIColor whiteColor];
            web.barTintColor =[UIColor orangeColor];
            web.progressViewColor = [UIColor blueColor];
            web.useGoback = NO;
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
