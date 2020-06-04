//
//  NSDate+SPTransform.m
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


#import "NSDate+SPTransform.h"
#import "NSString+SPMultiLanguage.h"

@implementation NSDate (SPTransform)

+(NSString*)sp_nowTimestampString
{
    return [[NSDate date] sp_timestampString];
}

+(double)sp_nowTimestamp
{
    return [[NSDate date] sp_timestamp];
}

-(NSString*)sp_timestampString
{
    return [NSString stringWithFormat:@"%llu",(UInt64)[self sp_timestamp]];
}

-(double)sp_timestamp
{
    return [self timeIntervalSince1970];
}

+ (NSDate *)sp_dateFromTimestampString:(NSString *)timestampString
{
    NSTimeInterval timeInterval = [timestampString doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

+ (NSDate *)sp_dateFromTimestamp:(double)timestamp
{
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

+ (NSDate *)sp_dateWithLocalNaturalLanguageString:(NSString *)timeString
{
    time_t timestamp;
    
    struct tm created;
    time_t now;
    time(&now);
    
    if (timeString)
    {
        if (strptime([timeString UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL)
        {
            if(NULL == strptime([timeString UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created)){
                return nil;
            }
        }
        
        timestamp = mktime(&created);
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        return date;
    }
    
    return nil;
}

- (NSDateFormatter *)dateFormatterFromCurrentThread
{
    return [NSDateFormatter sp_dateFormatterForCurrentThread];
}

- (NSCalendar *)calendarFromCurrentThread
{
    return [NSCalendar sp_calendarForCurrentThread];
}

- (NSString *)sp_formattedStringForMessageBoxDetailList
{
    NSCalendar* calendar= [self calendarFromCurrentThread];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateFormatter *dateFormatter = [self dateFormatterFromCurrentThread];
    
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    NSDateComponents *yesterdayComponents = [calendar components:unitFlags fromDate:[[NSDate date] dateByAddingTimeInterval:(-24*60*60)]];
    
    NSString *timeStr = nil;
    
    if ([nowComponents year] == [dateComponents year] &&
        [nowComponents month] == [dateComponents month] &&
        [nowComponents day] == [dateComponents day])
    {
        [dateFormatter setDateFormat:@"HH:mm"];
        timeStr = [dateFormatter stringFromDate:self];
    }
    else if([yesterdayComponents year] == [dateComponents year] &&
            [yesterdayComponents month] == [dateComponents month] &&
            [yesterdayComponents day] == [dateComponents day])
    {
        [dateFormatter setDateFormat:loadMuLanguage(@"'昨天 'HH:mm", @"")];
        timeStr = [dateFormatter stringFromDate:self];
    }
    else if([nowComponents year] == [dateComponents year])
    {
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        timeStr = [dateFormatter stringFromDate:self];
    }
    else
    {
        [dateFormatter setDateFormat:@"yy-MM-dd HH:mm"];
        timeStr = [dateFormatter stringFromDate:self];
    }
    
    return timeStr;
}

- (NSString *)sp_formattedStringForStatusDetail
{
    NSCalendar *calendar = [self calendarFromCurrentThread];
    NSDateFormatter *dateFormatter = [self dateFormatterFromCurrentThread];
    NSCalendarUnit unitFlags = NSYearCalendarUnit;
    
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    
    if (nowComponents.year == dateComponents.year) {
        [dateFormatter setDateFormat:@"M-d HH:mm"];
    }else{
        [dateFormatter setDateFormat:@"yy-M-d HH:mm"];
    }
    
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *)sp_briefRelativeFormattedString
{
    NSCalendar* calendar= [self calendarFromCurrentThread];
    NSCalendarUnit unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:self toDate:[NSDate date] options:0];
    
    NSString *timeStr = nil;
    
    if ([components day] >= 7)
    {
        timeStr = [NSString stringWithFormat:loadMuLanguage(@"%d周前", nil), 1];
    }
    else if ([components day] > 1)
    {
        timeStr = [NSString stringWithFormat:loadMuLanguage(@"%d天s前", nil), [components day]];
    }
    else if ([components day] == 1)
    {
        timeStr = [NSString stringWithFormat:loadMuLanguage(@"%d天前", nil), [components day]];
    }
    else if ([components hour] > 1)
    {
        timeStr = [NSString stringWithFormat:loadMuLanguage(@"%d小时s前", nil), [components hour]];
    }
    else if ([components hour] == 1)
    {
        timeStr = [NSString stringWithFormat:loadMuLanguage(@"%d小时前", nil), [components hour]];
    }
    else if ([components minute] > 1)
    {
        timeStr = [NSString stringWithFormat:loadMuLanguage(@"%d分钟s前", nil), [components minute]];
    }
    else
    {
        timeStr = [NSString stringWithFormat:loadMuLanguage(@"%d分钟前", nil), 1];
    }
    
    return timeStr;
}

- (NSString *)sp_generalRelativeFormattedStringWithTimeDescription:(spimeDisplayDescription *)description
{
    
    NSCalendar *calendar = [self calendarFromCurrentThread];
    NSCalendarUnit unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDateFormatter *dateFormatter = [self dateFormatterFromCurrentThread];
    
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    NSDateComponents *yesterdayComponents = [calendar components:unitFlags fromDate:[[NSDate date] dateByAddingTimeInterval:(-24*60*60)]];
    
    NSString *formattedString = nil;
    
    spimeDisplayDescription _description = spimeDisplayDescription_Other;
    
    if ([nowComponents year] == [dateComponents year] &&
        [nowComponents month] == [dateComponents month] &&
        [nowComponents day] == [dateComponents day])				// 今天
    {
        int diff = [self timeIntervalSinceNow];
        if (diff <= 0 && diff > -60 * 60 * 24)						// 一天之内.
        {
            int min = -diff / 60;
            
            if (min == 0)
            {
                min = 1;
            }
            
            if (min <= 10)                                          //10分钟
            {
                formattedString = [NSString stringWithFormat:loadMuLanguage(@"刚刚", @""), min];
                _description = spimeDisplayDescription_JustNow;
            }
            else if (min <= 59)                                     //一小时内
            {
                formattedString = [NSString stringWithFormat:loadMuLanguage(@"%d分钟前", @""), min];
                _description = spimeDisplayDescription_InOneHour;
            }
            else
            {
                int hour = min / 60;
                formattedString = [NSString stringWithFormat:loadMuLanguage(@"%d小时前", @""), hour];
                _description = spimeDisplayDescription_InOneDay;
            }
        }
        else if (diff > 0)
        {
            formattedString = [NSString stringWithFormat:loadMuLanguage(@"%d分钟前", @""), 1];
        }
    }
    else if([yesterdayComponents year] == [dateComponents year] &&
            [yesterdayComponents month] == [dateComponents month] &&
            [yesterdayComponents day] == [dateComponents day])          // 昨天
    {
        [dateFormatter setDateFormat:loadMuLanguage(@"'昨天 'HH:mm", @"")];
        formattedString = [dateFormatter stringFromDate:self];
        _description = spimeDisplayDescription_InYesterday;
    }
    else
    {
        NSLocale *mainlandChinaLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setLocale:mainlandChinaLocale];
        
        if ([nowComponents year] == [dateComponents year])
        {
            [dateFormatter setDateFormat:@"M-d"];
            _description = spimeDisplayDescription_InOneYear;
        }
        else
        {
            [dateFormatter setDateFormat:@"yy-M-d"];
            _description = spimeDisplayDescription_Other;
        }
        
        formattedString = [dateFormatter stringFromDate:self];
    }
    
    if (description != NULL) {
        *description = _description;
    }
    return formattedString;
    
}

- (NSString *)sp_generalRelativeFormattedString
{
    return [self sp_generalRelativeFormattedStringWithTimeDescription:NULL];
}

- (NSString *)sp_detailedrelativeFormattedString
{
    NSCalendar *calendar = [self calendarFromCurrentThread];
    NSCalendarUnit unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDateFormatter *dateFormatter = [self dateFormatterFromCurrentThread];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    NSDateComponents *yesterdayComponents = [calendar components:unitFlags fromDate:yesterday];
    
    NSString *formattedString = nil;
    
    if ([nowComponents year] == [dateComponents year] &&
        [nowComponents month] == [dateComponents month] &&
        [nowComponents day] == [dateComponents day])
    {
        [dateFormatter setDateFormat:@"H:mm"];
        formattedString = [dateFormatter stringFromDate:self];
    }
    else if ([yesterdayComponents year] == [dateComponents year] &&
             [yesterdayComponents month] == [dateComponents month] &&
             [yesterdayComponents day] == [dateComponents day])
    {
        formattedString = loadMuLanguage(@"昨天", @"");
    }
    else if ([nowComponents year] == [dateComponents year])
    {
        [dateFormatter setDateFormat:@"M-d"];
        formattedString = [dateFormatter stringFromDate:self];
    }
    else
    {
        [dateFormatter setDateFormat:@"yyyy-M-d"];
        formattedString = [dateFormatter stringFromDate:self];
    }
    
    
    return formattedString;
}

- (NSString *)sp_relativeFormattedString
{
    NSCalendar *calendar = [self calendarFromCurrentThread];
    NSCalendarUnit unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDateFormatter *dateFormatter = [self dateFormatterFromCurrentThread];
    
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    NSDateComponents *yesterdayComponents = [calendar components:unitFlags fromDate:[[NSDate date] dateByAddingTimeInterval:(-24*60*60)]];
    
    NSString *formattedString = nil;
    if ([nowComponents year] == [dateComponents year] &&
        [nowComponents month] == [dateComponents month] &&
        [nowComponents day] == [dateComponents day])				// 今天.
    {
        
        int diff = [self timeIntervalSinceNow];
        
        if (diff <= 0 && diff > -60 * 60)							// 一小时之内.
        {
            int min = -diff / 60;
            
            if (min == 0)
            {
                min = 1;
            }
            
            if (min <= 1)
            {
                formattedString = [NSString stringWithFormat:loadMuLanguage(@"刚刚", @""), min];
            }
            else
            {
                formattedString = [NSString stringWithFormat:loadMuLanguage(@"%d分钟前", @""), min];
            }
        }
        else if (diff > 0)
        {
            formattedString = [NSString stringWithFormat:loadMuLanguage(@"%d分钟前", @""), 1];
        }
        else
        {
            [dateFormatter setDateFormat:@"HH:mm"];
            formattedString = [dateFormatter stringFromDate:self];
        }
    }
    else if([yesterdayComponents year] == [dateComponents year] &&
            [yesterdayComponents month] == [dateComponents month] &&
            [yesterdayComponents day] == [dateComponents day])          // 昨天
    {
        [dateFormatter setDateFormat:loadMuLanguage(@"'昨天 'HH:mm", @"")];
        formattedString = [dateFormatter stringFromDate:self];
    }
    else
    {
        NSLocale *mainlandChinaLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setLocale:mainlandChinaLocale];
        
        if ([nowComponents year] == [dateComponents year])
        {
            [dateFormatter setDateFormat:@"M-d' 'HH:mm"];
        }
        else
        {
            [dateFormatter setDateFormat:@"yyyy-M-d' 'HH:mm"];
        }
        
        formattedString = [dateFormatter stringFromDate:self];
    }
    return formattedString;
}

- (NSString *)sp_dateTimeString
{
    NSCalendar *calendar = [self calendarFromCurrentThread];
    NSCalendarUnit unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateFormatter * formatter = [self dateFormatterFromCurrentThread];
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    
    NSLocale *mainlandChinaLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocale:mainlandChinaLocale];
    
    if ([nowComponents year] == [dateComponents year] &&
        [nowComponents month] == [dateComponents month] &&
        [nowComponents day] == [dateComponents day])
    {
        // 若为今天，不显示日期，只显示时间
        [formatter setDateFormat:@"HH:mm"];
    }
    else
    {
        [formatter setDateFormat:@"MM-dd' 'HH:mm"];
    }
    NSString * formatedString = [formatter stringFromDate:self];
    
    return formatedString;
}

- (NSString *)sp_stringWithFormatter:(NSString *)formatterString
{
    NSDateFormatter * formatter = [self dateFormatterFromCurrentThread];
    [formatter setDateFormat:formatterString];
    
    //    NSLocale *mainlandChinaLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //    [formatter setLocale:mainlandChinaLocale];
    //    [mainlandChinaLocale release];
    
    NSString * formatedString = [formatter stringFromDate:self];
    
    return formatedString;
}


+ (NSString *)sp_convertToTimeHeadFromTimeInterval:(NSTimeInterval)t
{
    NSString* time;
    NSCalendar* calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    double dd = t;
    NSDate* createdAt = [NSDate dateWithTimeIntervalSince1970:dd];
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *createdAtComponents = [calendar components:unitFlags fromDate:createdAt];
    if([nowComponents year] == [createdAtComponents year] &&
       [nowComponents month] == [createdAtComponents month] &&
       [nowComponents day] == [createdAtComponents day])
    {//今天
        [dateFormatter setDateFormat:loadMuLanguage(@"'今天 'HH:mm",@"")];
        
        time = [dateFormatter stringFromDate:createdAt];
        
    } else if ([nowComponents year] == [createdAtComponents year]) {
        NSLocale *cnLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setLocale:cnLocale];
        //		[dateFormatter setDateFormat:loadMuLanguage(@"MMMMd'日 'HH:mm",@"")];
        [dateFormatter setDateFormat:@"MM-dd' 'HH:mm"];
        time = [dateFormatter stringFromDate:createdAt];
    } else {//去年
        NSLocale *cnLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormatter setLocale:cnLocale];
        [dateFormatter setDateFormat:@"yyyy-MM-dd' 'HH:mm"];
        time = [dateFormatter stringFromDate:createdAt];
    }
    
    return time;
}

- (BOOL)sp_isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *dateCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == dateCmps.year;
}

- (BOOL)sp_isThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit =  NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month);
}

- (BOOL)sp_isThisToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

@end

static NSString * const kThreadDateFormatterKey = @"com.sina.weibo.thread-dateformatter";
static NSString * const kThreadNSCalendarKey = @"com.sina.weibo.thread-nscalendar";
static NSDateFormatter *formaterSingle;

@implementation NSDateFormatter (spUtilities)

+ (instancetype)sp_dateFormatterForCurrentThread
{
    NSMutableDictionary * currentThreadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter * dateFormatter = [currentThreadDictionary objectForKey:kThreadDateFormatterKey];
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [currentThreadDictionary setObject:dateFormatter forKey:kThreadDateFormatterKey];
    }
    return dateFormatter;
}

+ (instancetype)sp_dateFormatterSingle
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        formaterSingle = [[NSDateFormatter alloc] init];
    });
    return formaterSingle;
}
@end


@implementation NSCalendar (SPTransform)

+ (instancetype)sp_calendarForCurrentThread
{
    NSMutableDictionary * currentThreadDictionary = [[NSThread currentThread] threadDictionary];
    NSCalendar * calendar = [currentThreadDictionary objectForKey:kThreadNSCalendarKey];
    if (!calendar)
    {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [currentThreadDictionary setObject:calendar forKey:kThreadNSCalendarKey];
    }
    return calendar;
}

@end
