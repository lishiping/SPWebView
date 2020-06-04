//
//  UIBarButtonItem+JItem.m
//  jgdc
//
//  Created by lishiping on 2019/11/26.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "UIBarButtonItem+JItem.h"
#import <SPCategory/UIButton+SPAction.h>

@implementation UIBarButtonItem (JItem)



-(instancetype)initWithImage:(UIImage*)image color:(UIColor*)color click:(SPIdBlock)click
{
    UIButton *btn = [[UIButton alloc] init];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    image = [image imageWithColor:color?:UIColor.blackColor];
    [btn setImage:image forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 40, 44);
    [btn setExclusiveTouch:YES];
    [btn sp_button_onClickBlock:^(id object) {
        if (click) {
            click(object);
        }
    }];
    UIBarButtonItem *barButtonItem = [self initWithCustomView:btn];
    return barButtonItem;
}

@end
