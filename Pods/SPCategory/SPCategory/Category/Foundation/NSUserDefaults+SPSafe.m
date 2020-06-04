//
//  NSUserDefaults+SPTypeCast.m
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

#import "NSUserDefaults+SPSafe.h"
#import "SPTypeTransform.h"

/**
 *  返回根据所给 key 值在当前 userDefaults 对象上对应的值
 */
#define OFK [self objectForKey:key]

@implementation NSUserDefaults (SPSafe)

- (BOOL)sp_hasKey:(NSString *)key
{
    return (OFK != nil);
}

#pragma mark - NSObject

- (id)sp_objectForKey:(NSString *)key __attribute__((deprecated))
{
    return OFK;
}

- (id)sp_unknownObjectForKey:(NSString *)key
{
    return OFK;
}

- (id)sp_objectForKey:(NSString *)key class:(Class)clazz
{
    id obj = OFK;
    if ([obj isKindOfClass:clazz])
    {
        return obj;
    }
    
    return nil;
}

#pragma mark - NSArray

- (NSArray *)sp_arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    // sp_arrayOfValue 已实现判断
    return sp_arrayOfValue(OFK, defaultValue);
}

/// -arrayForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSArray.
- (NSArray *)sp_arrayForKey:(NSString *)key
{
    return [self sp_arrayForKey:key defaultValue:nil];
}

#pragma mark - BOOL

- (BOOL)sp_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    if ([OFK isKindOfClass:[NSNumber class]])
    {
        return [OFK boolValue];
    }
    else if ([OFK isKindOfClass:[NSString class]])
    {
        if ([OFK isEqualToString:@"YES"])
        {
            return YES;
        }
        else return NO;
    }
    
    return sp_boolOfValue(OFK, defaultValue);
}

/*!
 -boolForKey: is equivalent to -objectForKey:, except that it converts the returned value to a BOOL. If the value is an NSNumber, NO will be returned if the value is 0, YES otherwise. If the value is an NSString, values of "YES" or "1" will return YES, and values of "NO", "0", or any other string will return NO. If the value is absent or can't be converted to a BOOL, NO will be returned.
 
 */
- (BOOL)sp_boolForKey:(NSString *)key
{
    return [self sp_boolForKey:key defaultValue:NO];
}

#pragma mark - NSDictionary

- (NSDictionary *)sp_dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue
{
    // sp_dictOfValue 已实现判断
    return sp_dictOfValue(OFK, defaultValue);
}

/// -dictionaryForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSDictionary.
- (NSDictionary *)sp_dictionaryForKey:(NSString *)key
{
    return [self sp_dictionaryForKey:key defaultValue:nil];
}

#pragma mark - float

- (float)sp_floatForKey:(NSString *)key defaultValue:(float)defaultValue
{
    if ([OFK isKindOfClass:[NSNumber class]])
    {
        return [OFK floatValue];
    }
    else if ([OFK isKindOfClass:[NSString class]])
    {
        return [OFK floatValue];
    }
    return sp_floatOfValue(OFK, defaultValue);
}

/// -floatForKey: is similar to -integerForKey:, except that it returns a float, and boolean values will not be converted.
- (float)sp_floatForKey:(NSString *)key
{
    return [self sp_floatForKey:key defaultValue:0];
}

#pragma mark - double

- (double)sp_doubleForKey:(NSString *)key defaultValue:(double)defaultValue
{
    if ([OFK isKindOfClass:[NSNumber class]])
    {
        return [OFK doubleValue];
    }
    else if ([OFK isKindOfClass:[NSString class]])
    {
        return [OFK doubleValue];
    }
    return sp_doubleOfValue(OFK, defaultValue);
}

/// -doubleForKey: is similar to -doubleForKey:, except that it returns a double, and boolean values will not be converted.
- (double)sp_doubleForKey:(NSString *)key
{
    return [self sp_doubleForKey:key defaultValue:0];
}

#pragma mark - NSInteger

- (NSInteger)sp_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    if ([OFK isKindOfClass:[NSNumber class]])
    {
        return [OFK integerValue];
    }
    else if ([OFK isKindOfClass:[NSString class]])
    {
        return [OFK integerValue];
    }
    
    return sp_integerOfValue(OFK, defaultValue);
}

/*!
 -integerForKey: is equivalent to -objectForKey:, except that it converts the returned value to an NSInteger. If the value is an NSNumber, the result of -integerValue will be returned. If the value is an NSString, it will be converted to NSInteger if possible. If the value is a boolean, it will be converted to either 1 for YES or 0 for NO. If the value is absent or can't be converted to an integer, 0 will be returned.
 */
- (NSInteger)sp_integerForKey:(NSString *)key
{
    return [self sp_integerForKey:key defaultValue:0];
}

#pragma mark - NSArray of NSString

- (NSArray *)sp_stringArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    // sp_stringArrayOfValue 已实现判断
    return sp_stringArrayOfValue(OFK, defaultValue);
}

/// -stringForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSArray<NSString *>. Note that unlike -stringForKey:, NSNumbers are not converted to NSStrings.
- (NSArray *)sp_stringArrayForKey:(NSString *)key
{
    return [self sp_stringArrayForKey:key defaultValue:nil];
}

#pragma mark - NSString

- (NSString *)sp_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    if ([OFK isKindOfClass:[NSNumber class]])
    {
        return [OFK stringValue];
    }
    else if ([OFK isKindOfClass:[NSString class]])
    {
        return OFK;
    }
    
    return sp_stringOfValue(OFK, defaultValue);
}

/// -stringForKey: is equivalent to -objectForKey:, except that it will convert NSNumber values to their NSString representation. If a non-string non-number value is found, nil will be returned.
- (NSString *)sp_stringForKey:(NSString *)key
{
    return [self sp_stringForKey:key defaultValue:nil];
}

#pragma mark - NSURL

- (NSURL *)sp_urlForKey:(NSString *)key defaultValue:(NSURL *)defaultValue
{
    return sp_urlOfValue(OFK, defaultValue);
}

/*!
 -URLForKey: is equivalent to -objectForKey: except that it converts the returned value to an NSURL. If the value is an NSString path, then it will construct a file URL to that path. If the value is an archived URL from -setURL:forKey: it will be unarchived. If the value is absent or can't be converted to an NSURL, nil will be returned.
 */
- (NSURL *)sp_urlForKey:(NSString *)key
{
    return [self sp_urlForKey:key defaultValue:nil];
}

#pragma mark - NSData

- (NSData *)sp_dataForKey:(NSString *)key defaultValue:(NSData *)defaultValue
{
    // sp_dataOfValue 已实现判断，并且根据需要增加了对 NSString 的判断
    return sp_dataOfValue(OFK, defaultValue);
}

/// -dataForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSData.
- (NSData *)sp_dataForKey:(NSString *)key
{
    return [self sp_dataForKey:key defaultValue:nil];
}

#pragma mark - NSDate

- (NSDate *)sp_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue
{
    if ([OFK isKindOfClass:[NSDate class]])
    {
        return OFK;
    }
    
    return sp_dateOfValue(OFK);
}

- (NSDate *)sp_dateForKey:(NSString *)key
{
    return [self sp_dateForKey:key defaultValue:nil];
}

#pragma mark - NSNumber

- (NSNumber *)sp_numberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue
{
    if ([OFK isKindOfClass:[NSNumber class]])
    {
        return OFK;
    }
    
    return defaultValue;
}

- (NSNumber *)sp_numberForKey:(NSString *)key
{
    return [self sp_numberForKey:key defaultValue:nil];
}

#pragma mark - unsigned long long int
- (unsigned long long int)sp_unsiginedlonglongvalueForKey:(NSString *)key defaultValue:(unsigned long long int)defaultValue
{
    return sp_unsignedLongLongOfValue(OFK, defaultValue);
}

- (unsigned long long int)sp_unsiginedlonglongvalueForKey:(NSString *)key
{
    return [self sp_unsiginedlonglongvalueForKey:key defaultValue:0];
}

#pragma mark - NSUInteger
- (NSUInteger)sp_unsiginedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue
{
    return sp_unsignedIntegerOfValue(OFK, defaultValue);
}

- (NSUInteger)sp_unsiginedIntegerForKey:(NSString *)key
{
    return [self sp_unsiginedIntegerForKey:key defaultValue:0];
}

@end
