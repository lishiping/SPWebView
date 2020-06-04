//
//  NSUserDefaults+SPTypeCast.h
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

#import <Foundation/Foundation.h>


@interface NSUserDefaults (SPSafe)

#pragma mark - customize
/*!
 *  判断当前 userDefaults 是否包含指定的 key
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *
 *  @return     YES 表示包含，NO 表示不包含
 */
- (BOOL)sp_hasKey:(NSString *)key;

/*!
 *  返回指定 key 对应的 value
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *
 *  @return     返回指定 key 对应的 value
 */
- (id)sp_objectForKey:(NSString *)key __attribute__((deprecated));

/*!
 *  返回指定 key 对应的 value, 这个方法只用于特殊情况, 尽量使用指定类型的方法
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *
 *  @return     返回指定 key 对应的 value
 */
- (id)sp_unknownObjectForKey:(NSString *)key;

/*!
 *  返回指定 key 对应的 value 类型为 clazz 类型的对象，不是指定类型对象的对象返回 nil
 *
 *  @param key    用来获取当前 userDefaults 对应值的 key
 *  @param clazz  用于判断 key 对应的值是否满足该 Class 类型
 *
 *  @return       指定 key 对应的 value
 */
- (id)sp_objectForKey:(NSString *)key class:(Class)clazz;

#pragma mark - system

/*!
 *  返回当前 key 对应 value 的 BOOL 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 BOOL 类型时，返回该值
 *  @return              当 key 对应的值为 BOOL 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (BOOL)sp_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

/*!
 *  返回当前 key 对应 value 的 BOOL 值，没有则返回 NO
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 BOOL 类型时，返回该值，没有则返回 NO
 */
- (BOOL)sp_boolForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSData 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSData 类型时，返回该值
 *  @return              当 key 对应的值为 NSData 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (NSData *)sp_dataForKey:(NSString *)key defaultValue:(NSData *)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSData 值，没有则返回 nil
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 NSData 类型时，返回该值，没有则返回 nil
 */
- (NSData *)sp_dataForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSDictionary 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSDictionary 类型时，返回该值
 *  @return              当 key 对应的值为 NSDictionary 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (NSDictionary *)sp_dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSDictionary 值，没有则返回 nil
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 NSDictionary 类型时，返回该值，没有则返回 nil
 */
- (NSDictionary *)sp_dictionaryForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSURL 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSURL 类型时，返回该值
 *  @return              当 key 对应的值为 NSURL 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (NSURL *)sp_urlForKey:(NSString *)key defaultValue:(NSURL *)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSURL 值，没有则返回 nil
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 NSURL 类型时，返回该值，没有则返回 nil
 */
- (NSURL *)sp_urlForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 float 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 float 类型时，返回该值
 *  @return              当 key 对应的值为 float 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (float)sp_floatForKey:(NSString *)key defaultValue:(float)defaultValue;

/*!
 *  返回当前 key 对应 value 的 float 值，没有则返回 0
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 float 类型时，返回该值，没有则返回 0
 */
- (float)sp_floatForKey:(NSString *)key;


/*!
 *  返回当前 key 对应 value 的 double 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 double 类型时，返回该值
 *  @return              当 key 对应的值为 double 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (double)sp_doubleForKey:(NSString *)key defaultValue:(double)defaultValue;

/*!
 *  返回当前 key 对应 value 的 double 值，没有则返回 0
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 double 类型时，返回该值，没有则返回 0
 */
- (double)sp_doubleForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSInteger 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSInteger 类型时，返回该值
 *  @return              当 key 对应的值为 NSInteger 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (NSInteger)sp_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSInteger 值，没有则返回 0
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 NSInteger 类型时，返回该值，没有则返回 0
 */
- (NSInteger)sp_integerForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSString 数组，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSString 数组时，返回该值
 *  @return              当 key 对应的值为 NSString 数组时，返回该值，不是则返回 defaultValue
 *
 */
- (NSArray *)sp_stringArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSString 数组，没有则返回 nil
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 NSString 数组时，返回该值，不是则返回 nil
 */
- (NSArray *)sp_stringArrayForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSArray 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSArray 类型时，返回该值
 *  @return              当 key 对应的值为 NSArray 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (NSArray *)sp_arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSArray 值，没有则返回 nil
 *
 *  @param key  用来获取当前字典对应值的 key
 *  @return     当 key 对应的值为 NSArray 类型时，返回该值，没有则返回 nil
 */
- (NSArray *)sp_arrayForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSString 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSString 类型时，返回该值
 *  @return              当 key 对应的值为 NSString 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (NSString *)sp_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSString 值，没有则返回 nil
 *
 *  @param key  用来获取当前字典对应值的 key
 *  @return     当 key 对应的值为 NSString 类型时，返回该值，没有则返回 nil
 */
- (NSString *)sp_stringForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSDate 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSDate 类型并且不能转换时，返回该值
 *  @return              当 key 对应的值为 NSDate 类型或者可以转换为 NSDate 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (NSDate *)sp_dateForKey:(NSString *)key defaultValue:(NSDate *)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSDate 值，没有则返回 nil
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 NSDate 类型时，返回该值，没有则返回 nil
 */
- (NSDate *)sp_dateForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSNumber 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSNumber 类型时，返回该值
 *  @return              当 key 对应的值为 NSNumber 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (NSNumber *)sp_numberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSNumber 值，没有则返回 nil
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 NSNumber 类型时，返回该值，没有则返回 nil
 */
- (NSNumber *)sp_numberForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 unsigned long long int 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 unsigned long long int 类型时，返回该值
 *  @return              当 key 对应的值为 unsigned long long int 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (unsigned long long int)sp_unsiginedlonglongvalueForKey:(NSString *)key defaultValue:(unsigned long long int)defaultValue;

/*!
 *  返回当前 key 对应 value 的 NSUInteger 值，没有则返回 nil
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 NSUInteger 类型时，返回该值，没有则返回 nil
 */
- (unsigned long long int)sp_unsiginedlonglongvalueForKey:(NSString *)key;

/*!
 *  返回当前 key 对应 value 的 NSUInteger 值，没有则返回 defaultValue
 *
 *  @param key           用来获取当前 userDefaults 对应值的 key
 *  @param defaultValue  当 key 对应的 value 值不是 NSUInteger 类型时，返回该值
 *  @return              当 key 对应的值为 NSUInteger 类型时，返回该值，没有则返回 defaultValue
 *
 */
- (NSUInteger)sp_unsiginedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue;

/*!
 *  返回当前 key 对应 value 的 unsigned long long int 值，没有则返回 nil
 *
 *  @param key  用来获取当前 userDefaults 对应值的 key
 *  @return     当 key 对应的值为 unsigned long long int 类型时，返回该值，没有则返回 nil
 */
- (NSUInteger)sp_unsiginedIntegerForKey:(NSString *)key;

@end
