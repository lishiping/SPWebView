//
//  UIView+SPAction.m
//  jgdc
//
//  Created by lishiping on 2019/9/23.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "UIView+SPAction.h"
#import "NSObject+SPAssociatedObject.h"

@implementation UIView (SPAction)

-(UIGestureRecognizer*)sp_view_onClickBlock:(SPIdBlock)block
{
    [self sp_setObject:block forAssociatedKey:@"sp_view_tap_action" associationPolicy:OBJC_ASSOCIATION_COPY_NONATOMIC];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sp_view_callActionBlock:)];
    [self addGestureRecognizer:tap];
    return tap;
}

- (void)sp_view_callActionBlock:(id)sender {
    SPIdBlock block = [self sp_objectWithAssociatedKey:@"sp_view_tap_action"];
    if(block)
    {
        block(sender);
    }
}

-(UIGestureRecognizer*)sp_view_longPressBlock:(SPIdBlock)block
{
    [self sp_setObject:block forAssociatedKey:@"sp_view_longPress_action" associationPolicy:OBJC_ASSOCIATION_COPY_NONATOMIC];
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(sp_view_longPressCallBack:)];
    [self addGestureRecognizer:longPress];
    return longPress;
}

- (void)sp_view_longPressCallBack:(id)sender {
    SPIdBlock block = [self sp_objectWithAssociatedKey:@"sp_view_longPress_action"];
    if(block)
    {
        block(sender);
    }
}

@end
