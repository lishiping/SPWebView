//
//  UITableViewCell+SPReuseIdentifier.m
//  SPCategory
//
//  Created by shiping li on 2018/1/30.
//  Copyright © 2018年 lishiping. All rights reserved.
//

#import "UITableViewCell+SPReuseIdentifier.h"

@implementation UITableViewCell (SPReuseIdentifier)

+(NSString*)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
