//
//  HomeVC.h
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

#import "HomeVC.h"
#import "SPWebListDemo.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    test.frame = CGRectMake(100, 200, 200, 35);
    test.layer.cornerRadius = 5;
    test.backgroundColor = [UIColor redColor];
    [test setTitle:@"测试web列表" forState:UIControlStateNormal];
    [self.view addSubview:test];
    [test addTarget:self action:@selector(openWebList) forControlEvents:UIControlEventTouchUpInside];
}


- (void)openWebList {
    
    SPWebListDemo *rxVC = [[SPWebListDemo alloc]init];
    [self.navigationController pushViewController:rxVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
