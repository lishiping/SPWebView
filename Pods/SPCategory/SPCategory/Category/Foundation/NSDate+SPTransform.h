//
//  NSDate+SPTransform.h
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
/*!
 *  将NSDate转换成相应文字描述字符串的工具方法。
 */

typedef enum{
    
    spimeDisplayDescription_JustNow,
    
    spimeDisplayDescription_InOneDay,
    
    spimeDisplayDescription_InYesterday,
    
    spimeDisplayDescription_InOneHour,
    
    spimeDisplayDescription_InOneYear,
    
    spimeDisplayDescription_Other,
    
}spimeDisplayDescription;

@interface NSDate (SPTransform)

#pragma mark - 获取时间戳，这里的时间戳都是毫秒
/**
 获取当前日期的时间戳字符串

 @return 时间戳字符串
 */
+(NSString*)sp_nowTimestampString;

/**
 获取当前日期的时间戳

 @return 时间戳
 */
+(double)sp_nowTimestamp;

/**
 获取日期对象的时间戳字符串
 
 @return 时间戳字符串
 */
-(NSString*)sp_timestampString;

/**
 获取日期对象的时间戳
 
 @return 时间戳
 */
-(double)sp_timestamp;

/**
 通过时间戳字符串得到时间日期

 @param timestampString 时间戳字符串
 @return 日期
 */
+ (NSDate *)sp_dateFromTimestampString:(NSString *)timestampString;

/**
 通过时间戳得到时间日期

 @param timestamp 时间戳
 @return 时间日期
 */
+ (NSDate *)sp_dateFromTimestamp:(double)timestamp;

#pragma mark -字符串转时间
/*!
 *  将日期形式的字符串转换成NSDate  例如（Wed Dec 27 15:58:29 +0800 2017）
 *
 *  @param timeString 要转换为NSDate的NSString
 *
 *  @return 转换后的NSDate
 */
+ (NSDate *)sp_dateWithLocalNaturalLanguageString:(NSString *)timeString;

/*!
 *  根据指定的NSTimeInterval，生成并返回转换成时间格式的NSString对象
 *  如“今天 12：30”
 *
 *  @param t 需要转换的NSTimeInterval
 *
 *  @return 转换后的NSString
 */
+ (NSString *)sp_convertToTimeHeadFromTimeInterval:(NSTimeInterval)t;

/*!
 *  根据当前的NSDate，生成并返回一个相对时间描述的NSString对象
 *  如“2分钟前”
 *
 *  @return 转换后的NSString
 */
- (NSString *)sp_relativeFormattedString;

/*!
 *  根据当前的NSDate，生成并返回一个相对时间描述的NSString对象
 *  如“刚刚”
 *
 *  @return 转换后的NSString
 */
- (NSString *)sp_generalRelativeFormattedString;
- (NSString *)sp_generalRelativeFormattedStringWithTimeDescription:(spimeDisplayDescription *)description;

/*!
 *  根据当前的NSDate，生成并返回一个相对时间描述的NSString对象
 *  如“3周前”
 *
 *  @return 转换后的NSString
 */
- (NSString *)sp_briefRelativeFormattedString;

/*!
 *  根据当前的NSDate，生成并返回一个相对时间描述的NSString对象
 *  如“12：35”或 如果转换日期不是今日，显示“4月20日 12：35”
 *
 *  @return 转换后的NSString
 */
- (NSString *)sp_dateTimeString;

/*!
 *  根据当前的NSDate，生成并返回一个相对时间描述的NSString对象
 *  如“2014-04-21 12:40“
 *
 *  @return 转换后的NSString
 */
- (NSString *)sp_formattedStringForMessageBoxDetailList;

/*!
 *  根据当前的NSDate，生成并返回一个相对时间描述的NSString对象
 *  如“昨天“
 *
 *  @return 转换后的NSString
 */
- (NSString *)sp_detailedrelativeFormattedString;

/*!
 *  根据指定的时间格式字符串，生成并返回一个当前日期的NSString对象
 *
 *  @param formatterString 格式化String
 *
 *  @return 格式化NSDate后的string
 */
- (NSString *)sp_stringWithFormatter:(NSString *)formatterString;

/*!
 *  将本身转换成一个绝对的格式返回“2014-04-21 12:40“
 */
- (NSString *)sp_formattedStringForStatusDetail;

/*！
 * 当判断当前的 NSDate 是否是今年
 *
 *  @return YES for 今年
 */
- (BOOL)sp_isThisYear;


/**
 判断是否是本月月

 @return yes for 本月
 */
- (BOOL)sp_isThisMonth;

/**
 *  判断是否为今天
 *
 *  @return 判断是否为今天
 */
- (BOOL)sp_isThisToday;

@end

// NSDateFormatter 与 NSCalendar 的初始化非常慢（“比文字绘制还慢” by instruments），
// 但它们又不是线程安全的：
// http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Multithreading/ThreadSafetySummary/ThreadSafetySummary.html#//apple_ref/doc/uid/10000057i-CH12-122647-BBCCEGFF
// 以下两个方法按当前线程提供缓存过的 formatter 与 calendar

@interface NSDateFormatter (spUtilities)

+ (instancetype)sp_dateFormatterForCurrentThread;

/**
 *  @abstract   返回cache的唯一formatter
 *  @discussion 依据文档iOS7以后NSDateFormatter已经是线程安全，只需要缓存一份即可，不用每个线程都初始化消耗性能（）
 *  @return     实例化的formatter
 */
+ (instancetype)sp_dateFormatterSingle;


@end

@interface NSCalendar (SPTransform)

+ (instancetype)sp_calendarForCurrentThread;

@end
