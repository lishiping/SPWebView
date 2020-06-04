//
//  UIView+SPReuseIdentifier.m
//  SPCategory
//
//  Created by shiping li on 2018/1/30.
//  Copyright © 2018年 lishiping. All rights reserved.
//

#import "UIView+SPReuseIdentifier.h"

@implementation UIView (SPReuseIdentifier)

+(NSString*)sp_reuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
