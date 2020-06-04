//
//  UILabel+SPAction.m
//  jgdc
//
//  Created by lishiping on 2019/9/20.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "UILabel+SPAction.h"
#import "NSObject+SPAssociatedObject.h"

@implementation UILabel (SPAction)

-(UIGestureRecognizer*)sp_label_onClickBlock:(SPIdBlock)block
{
    [self sp_setObject:block forAssociatedKey:@"sp_label_action" associationPolicy:OBJC_ASSOCIATION_COPY_NONATOMIC];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sp_label_callActionBlock:)];
    [self addGestureRecognizer:tap];
    return tap;
}
- (void)sp_label_callActionBlock:(id)sender {
    SPIdBlock block = [self sp_objectWithAssociatedKey:@"sp_label_action"];
    if(block)
    {
        block(sender);
    }
}

@end
