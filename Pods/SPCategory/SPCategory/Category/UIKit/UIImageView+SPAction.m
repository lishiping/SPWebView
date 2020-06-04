//
//  UIImageView+SPAction.m
//  jgdc
//
//  Created by lishiping on 2019/9/20.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "UIImageView+SPAction.h"
#import "NSObject+SPAssociatedObject.h"

@implementation UIImageView (SPAction)

-(UIGestureRecognizer*)sp_imageView_onClickBlock:(SPIdBlock)block
{
    [self sp_setObject:block forAssociatedKey:@"sp_imageView_action" associationPolicy:OBJC_ASSOCIATION_COPY_NONATOMIC];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sp_imageView_callActionBlock:)];
    [self addGestureRecognizer:tap];

    return tap;
}
- (void)sp_imageView_callActionBlock:(id)sender {
    SPIdBlock block = [self sp_objectWithAssociatedKey:@"sp_imageView_action"];
    if(block)
    {
        block(sender);
    }
}

@end
