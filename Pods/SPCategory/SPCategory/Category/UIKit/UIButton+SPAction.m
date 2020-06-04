//
//  UIButton+SPAction.m
//  jgdc
//
//  Created by lishiping on 2019/9/10.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "UIButton+SPAction.h"
#import "NSObject+SPAssociatedObject.h"

@implementation UIButton (SPAction)
-(void)sp_button_onClickBlock:(SPIdBlock)action
{
    [self sp_setObject:action forAssociatedKey:@"sp_button_action" associationPolicy:OBJC_ASSOCIATION_COPY_NONATOMIC];
    [self addTarget:self action:@selector(sp_button_callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)sp_button_callActionBlock:(id)sender {
    SPIdBlock block = [self sp_objectWithAssociatedKey:@"sp_button_action"];
    if(block)
    {
        block(sender);
    }
}
@end
