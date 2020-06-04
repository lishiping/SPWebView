//
//  UIView+SPBorder.m
//  jgdc
//
//  Created by lishiping on 2019/10/30.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "UIView+SPBorder.h"

@implementation UIView (SPBorder)

-(void)sp_border_radius:(UIRectCorner)border_radius corner:(CGFloat)corner{
   return [self sp_border_radius:border_radius cornerRadii:CGSizeMake(corner, corner)];
}

-(void)sp_border_radius:(UIRectCorner)border_radius cornerRadii:(CGSize)cornerRadii
{
    if (cornerRadii.width>0||cornerRadii.height>0) {
        CAShapeLayer *shape = [[CAShapeLayer alloc] init];
        UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:border_radius cornerRadii:cornerRadii];
        [shape setPath:rounded.CGPath];
        self.layer.mask = shape;
    }
}

@end
