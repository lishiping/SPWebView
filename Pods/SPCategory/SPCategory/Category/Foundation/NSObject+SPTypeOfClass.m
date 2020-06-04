//
//  NSObject+SPTypeOfClass.m
//  SPCategory
//
//  Created by lishiping on 2019/9/2.
//  Copyright © 2019 lishiping. All rights reserved.
//

#import "NSObject+SPTypeOfClass.h"

@implementation NSObject (SPTypeOfClass)
-(BOOL)sp_isString
{
    return [self isKindOfClass:[NSString class]] && [(NSString*)self length] > 0;
}
-(BOOL)sp_isMutableString
{
    return [self isKindOfClass:[NSMutableString class]];
}

-(BOOL)sp_isArray
{
    return [self isKindOfClass:[NSArray class]] && [(NSArray*)self count] > 0;
}
-(BOOL)sp_isMutableArray
{
    return [self isKindOfClass:[NSMutableArray class]];
}

-(BOOL)sp_isDictionary
{
    return [self isKindOfClass:[NSDictionary class]] && [(NSDictionary*)self count] > 0;
}
-(BOOL)sp_isMutableDictionary
{
    return [self isKindOfClass:[NSMutableDictionary class]];
}

-(BOOL)sp_isNumber
{
    return [self isKindOfClass:[NSNumber class]];
}

-(BOOL)sp_isData
{
    return [self isKindOfClass:[NSData class]] &&[(NSData*)self length] > 0;
}

@end
