//
//  SPTypeTransform.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//
//If you feel this open source library is of great help to you, please open the URL to the point of a great, great encouragement your recognition to the author, the author will release better open source library for you again
//如果您感觉本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会再发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory
//github address//https://github.com/lishiping/SPBaseClass

#import "SPTypeTransform.h"
#import "NSObject+SPAssociatedObject.h"

id sp_nonnullValue(id value)
{
    if (nil == value) return nil;
    
    if ([value isKindOfClass:NSDictionary.class])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [(NSDictionary *)value enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (obj != [NSNull null]) {
                
                obj = sp_nonnullValue(obj);
                if (nil != obj)
                {
                    [dict setObject:obj forKey:key];
                }
                
            }
        }];
        
        return dict;
    }
    else if ([value isKindOfClass:NSArray.class])
    {
        NSMutableArray *array = [NSMutableArray array];
        [(NSArray *)value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (obj != [NSNull null]) {
                
                obj = sp_nonnullValue(obj);
                if (nil != obj)
                {
                    [array addObject:obj];
                }
                
            }
        }];
        return array;
    }
    else if (value != [NSNull null])
    {
        return value;
    }
    
    return nil;
}

NSNumber *sp_numberOfValue(id value, NSNumber *defaultValue)
{
    NSNumber *returnValue = defaultValue;
    if (![value isKindOfClass:[NSNumber class]])
    {
        if ([value isKindOfClass:NSString.class])
        {
            NSThread *thread = [NSThread currentThread];
            NSNumberFormatter *formatter = [thread sp_objectWithAssociatedKey:@"TypeCastUtil.NumberFormatter"];
            if (!formatter)
            {
                formatter = [[NSNumberFormatter alloc] init] ;//autorelease];
                [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                [thread sp_setObject:formatter forAssociatedKey:@"TypeCastUtil.NumberFormatter" retained:YES];
            }
            
            returnValue = [formatter numberFromString:(NSString *)value];
        }
    }
    else
    {
        returnValue = value;
    }
    
    return returnValue;
}

NSString *sp_stringOfValue(id value, NSString *defaultValue)
{
    if (![value isKindOfClass:[NSString class]])
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            return [value stringValue];
        }
        return defaultValue;
    }
    return value;
}

NSArray *sp_stringArrayOfValue(id value, NSArray *defaultValue)
{
    if (![value isKindOfClass:[NSArray class]])
        return defaultValue;
    
    for (id item in value) {
        if (![item isKindOfClass:[NSString class]])
            return defaultValue;
    }
    return value;
}

NSDictionary *sp_dictOfValue(id value, NSDictionary *defaultValue)
{
    if ([value isKindOfClass:[NSDictionary class]])
        return value;
    
    return defaultValue;
}

NSArray *sp_arrayOfValue(id value ,NSArray *defaultValue)
{
    if ([value isKindOfClass:[NSArray class]])
        return value;
    
    return defaultValue;
}

float sp_floatOfValue(id value, float defaultValue)
{
    if ([value respondsToSelector:@selector(floatValue)])
        return [value floatValue];
    
    return defaultValue;
}

double sp_doubleOfValue(id value, double defaultValue)
{
    if ([value respondsToSelector:@selector(doubleValue)])
        return [value doubleValue];
    
    return defaultValue;
}

CGPoint sp_pointOfValue(id value, CGPoint defaultValue)
{
    if (value && [value isKindOfClass:[NSString class]] && ((NSString*)value).length>0)
        return CGPointFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGPointValue];
    
    return defaultValue;
}

CGSize sp_sizeOfValue(id value, CGSize defaultValue)
{
    if ([value isKindOfClass:[NSString class]] && ((NSString*)value).length>0 )
        return CGSizeFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGSizeValue];
    
    return defaultValue;
}

CGRect sp_rectOfValue(id value, CGRect defaultValue)
{
    if ([value isKindOfClass:[NSString class]] && ((NSString*)value).length>0)
        return CGRectFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGRectValue];
    
    return defaultValue;
}

BOOL sp_boolOfValue(id value, BOOL defaultValue)
{
    if ([value respondsToSelector:@selector(boolValue)])
        return [value boolValue];
	
    return defaultValue;
}

int sp_intOfValue(id value, int defaultValue)
{
    if ([value respondsToSelector:@selector(intValue)])
        return [value intValue];
    
    return defaultValue;
}

unsigned int sp_unsignedIntOfValue(id value, unsigned int defaultValue)
{
    if ([value respondsToSelector:@selector(unsignedIntValue)])
        return [value unsignedIntValue];
    
    return defaultValue;
}

long long int sp_longLongOfValue(id value, long long int defaultValue)
{
    if ([value respondsToSelector:@selector(longLongValue)])
        return [value longLongValue];
    
    return defaultValue;
}

unsigned long long int sp_unsignedLongLongOfValue(id value, unsigned long long int defaultValue)
{
    if ([value respondsToSelector:@selector(unsignedLongLongValue)])
        return [value unsignedLongLongValue];
    
    return defaultValue;
}

NSInteger sp_integerOfValue(id value, NSInteger defaultValue)
{
    if ([value respondsToSelector:@selector(integerValue)])
        return [value integerValue];
    
    return defaultValue;
}

NSUInteger sp_unsignedIntegerOfValue(id value, NSUInteger defaultValue)
{
    if ([value respondsToSelector:@selector(unsignedIntegerValue)])
        return [value unsignedIntegerValue];
    
    return defaultValue;
}

UIImage *sp_imageOfValue(id value, UIImage *defaultValue)
{
    if ([value isKindOfClass:[UIImage class]])
        return value;
    
    return defaultValue;
}

UIColor *sp_colorOfValue(id value, UIColor *defaultValue)
{
    if ([value isKindOfClass:[UIColor class]])
        return value;
    
    return defaultValue;
}

time_t sp_timeOfValue(id value, time_t defaultValue)
{
    NSString *stringTime = sp_stringOfValue(value, nil);
    
    struct tm created;
    time_t now;
    time(&now);
    
    if (stringTime)
    {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL)
        {
            // 为了兼顾 userDefaults 可能传值不正确的情况
            if (strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created) == NULL)
            {
                return defaultValue;
            }
        }
        
        return mktime(&created);
    }
    
    return defaultValue;
}

NSDate *sp_dateOfValue(id value)
{
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [NSDate dateWithTimeIntervalSince1970:[value intValue]];
    }
    else if ([value isKindOfClass:[NSString class]] && [value length] > 0)
    {
        return [NSDate dateWithTimeIntervalSince1970:sp_timeOfValue(value, [[NSDate date] timeIntervalSince1970])];
    }
    
    return nil;
}


NSData *sp_dataOfValue(id value, NSData *defaultValue)
{
    if ([value isKindOfClass:[NSData class]])
    {
        return value;
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return [value dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    return defaultValue;
}

NSURL *sp_urlOfValue(id value, NSURL *defaultValue)
{
    if ([value isKindOfClass:[NSURL class]])
    {
        return value;
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return [NSURL fileURLWithPath:value];
    }
    else if ([value isKindOfClass:[NSData class]])
    {
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:value];
        if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            
            return url;
        }
    }
    
    return defaultValue;
}
