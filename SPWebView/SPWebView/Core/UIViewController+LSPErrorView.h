//
//  UIViewController+LSPErrorView.h
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSPErrorView.h"

@interface UIViewController (SPErrorView)

@property (nonatomic, strong) LSPErrorView *spErrorView;//错误页


/***************无网络等错误页***************/
-(void)addspErrorViewWithTitle:(NSString*)title;

-(void)removespErrorView;

//实现下面的方法，点击回调重新刷新数据
//        _var_weakSelf;
//        spErrorView.tapBlock = ^(void){
////            [weakSelf queryListData];
//        };


@end
