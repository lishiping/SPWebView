//
//  UITableView+SPInit.m
//  jgdc
//
//  Created by lishiping on 2019/12/3.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "UITableView+SPInit.h"

@implementation UITableView (SPInit)

- (instancetype)sp_initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    UITableView *instance = [self initWithFrame:frame style:style];
    
    if (@available(iOS 11.0, *)) {
        instance.estimatedRowHeight = 0;
        instance.estimatedSectionFooterHeight = 0;
        instance.estimatedSectionHeaderHeight = 0;
        instance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    // 隐藏系统分割线
    instance.separatorColor = [UIColor clearColor];
    
    return instance;
}

@end
