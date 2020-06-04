//
//  NSString+SPEncode.m
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


#import "NSString+SPEnCode.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (SPEnCode)

#pragma mark - enCode(编码)

- (NSData *)toDataUTF8
{
    return  [self toDataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)toDataUsingEncoding:(NSStringEncoding)encoding
{
    return ([self dataUsingEncoding:encoding]);
}

- (NSString *)md5
{
    return [NSString md5String:self];
}

+ (NSString *)md5String:(NSString *)str;
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)emojiString
{
    if (self.length)
    {
        NSData *data = [self dataUsingEncoding:NSNonLossyASCIIStringEncoding];
        NSString *valueUnicode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSData *dataa = [valueUnicode dataUsingEncoding:NSUTF8StringEncoding];
        NSString *valueEmoj = [[NSString alloc] initWithData:dataa encoding:NSNonLossyASCIIStringEncoding];
        return valueEmoj;
    }
    else
    {
        return self;
    }
}

-(NSURL*)getURLByurlEncode
{
    if (self.length>0)
    {
        NSString *urlString = [self getStringByurlEncode];
        if (urlString.length>0) {
            return [NSURL URLWithString:urlString];
        }
    }
    return nil;
}

-(NSString*)getStringByurlEncode
{
    if (self.length>0)
    {
        NSString *absoluteString = self;
        
        NSRange rg = [absoluteString rangeOfString:@"?"];
        
        NSString *queryStr = [absoluteString substringWithRange:NSMakeRange(rg.location+1, absoluteString.length-rg.location-1)];
        
        NSDictionary *dic = [queryStr getParamFromURLByurlEncode];
        
        NSString *parameters = [self stringForHTTPBySortParameters:dic];
        
        NSString *urlString = [absoluteString substringToIndex:rg.location+1];
        
        if (urlString.length>0&&parameters.length>0) {
            urlString = [urlString stringByAppendingString:parameters];
        }
        
        return urlString;
    }
    return nil;
}

-(NSURL*)getURLByurlDecode
{
    if (self.length>0)
    {
        NSString *urlString = [self getStringByurlDecode];
        if (urlString.length>0) {
            return [NSURL URLWithString:urlString];
        }
    }
    return nil;
}

-(NSString*)getStringByurlDecode
{
    if (self.length>0)
    {
        NSString *absoluteString = self;
        
        NSDictionary *dic = [self getParamFromURLByurlDecode];
        
        NSString *parameters = [self stringForHTTPBySortParameters:dic];
        
        NSRange rg = [absoluteString rangeOfString:@"?"];
        
        NSString *urlString = [absoluteString substringToIndex:rg.location+1];
        
        if (urlString.length>0&&parameters.length>0) {
            urlString = [urlString stringByAppendingString:parameters];
        }
        
        return urlString;
    }
    return nil;
}

//从url得到请求参数
-(NSDictionary*)getParamFromURLByurlEncode
{
    if (self.length>0)
    {
        NSString *queryStr = self;
        if (((NSRange)[queryStr rangeOfString:@"?"]).location!=NSNotFound) {
            
            NSRange rg = [queryStr rangeOfString:@"?"];
            queryStr = [queryStr substringWithRange:NSMakeRange(rg.location+1, queryStr.length-rg.location-1)];
        }
        
        NSArray *queryArr = [queryStr componentsSeparatedByString:@"&"];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        for (NSString *querytemp in queryArr) {
            NSArray *keyvalue = [querytemp componentsSeparatedByString:@"="];
            NSString *key = keyvalue[0];
            NSString *value =keyvalue[1];
            if (key.length>0&&value.length>0) {
                [mDic setObject:value.urlEncode forKey:key];
            }
        }
        
        return [mDic copy];
    }
    return nil;
}

//从url得到请求参数
-(NSDictionary*)getParamFromURLByurlDecode
{
    if (self.length>0)
    {
        NSString *queryStr = self;
        if (((NSRange)[queryStr rangeOfString:@"?"]).location!=NSNotFound) {
            
            NSRange rg = [queryStr rangeOfString:@"?"];
            queryStr = [queryStr substringWithRange:NSMakeRange(rg.location+1, queryStr.length-rg.location-1)];
        }
        
        NSArray *queryArr = [queryStr componentsSeparatedByString:@"&"];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        for (NSString *querytemp in queryArr) {
            NSArray *keyvalue = [querytemp componentsSeparatedByString:@"="];
            NSString *key = keyvalue[0];
            NSString *value =keyvalue[1];
            if (key.length>0&&value.length>0) {
                [mDic setObject:value.urlDecode forKey:key];
            }
        }
        
        return [mDic copy];
    }
    return nil;
}

//对请求参数排序并生成字符串，为了计算md5值
- (NSString *)stringForHTTPBySortParameters:(NSDictionary*)param
{
    NSString *ret = nil;
    
    if (param.count>0)
    {
        // 对字典key排序，保证param的顺序不影响最后结果
        NSArray *arr = [[param allKeys] sortedArrayWithOptions:NSSortConcurrent
                                               usingComparator:^NSComparisonResult(id obj1, id obj2){
                                                   if (([obj1 isKindOfClass:[NSString class]]) &&
                                                       ([obj2 isKindOfClass:[NSString class]]))
                                                   {
                                                       return ([obj1 compare:obj2]);
                                                   }
                                                   return (NSOrderedSame);
                                               }];
        if (arr.count > 0)
        {
            NSMutableArray *mArr = [NSMutableArray array];
            
            for (NSString *key in arr)
            {
                NSString *value =[param objectForKey:key];
                if (key.length>0&&value.length>0) {
                    NSString *str = [NSString stringWithFormat:@"%@=%@",key,value];
                    [mArr addObject:str];
                }
            }
            
            //数组中间加上地址符
            ret = [mArr componentsJoinedByString:@"&"];
        }
    }
    
    return ret;
}

- (NSString *)urlEncode
{
    NSString *url = nil;
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0) {
        url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)self,  NULL,  (CFStringRef)@"!*'();:@&=+$,/?%#[]",  kCFStringEncodingUTF8));
    }
    else
    {
        // RFC 3986 规范
        NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`-_"].invertedSet;
        url =  [self stringByAddingPercentEncodingWithAllowedCharacters:charset];
    }
    
    return url;
}


- (NSString *)urlDecode;
{
    return [self stringByRemovingPercentEncoding];
}


#pragma mark - judge(判断)

+ (BOOL)isEmpty:(NSString *)string
{
    return string == nil || string.length == 0;
}

- (BOOL)isContainsEmoji;
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff)
        {
            if (substring.length > 1)
            {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f)
                {
                    returnValue = YES;
                }
            }
        }
        else if (substring.length > 1)
        {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3)
            {
                returnValue = YES;
            }
        }
        else
        {
            if (0x2100 <= hs && hs <= 0x27ff)
            {
                returnValue = YES;
            }
            else if (0x2B05 <= hs && hs <= 0x2b07)
            {
                returnValue = YES;
            }
            else if (0x2934 <= hs && hs <= 0x2935)
            {
                returnValue = YES;
            }
            else if (0x3297 <= hs && hs <= 0x3299)
            {
                returnValue = YES;
            }
            else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
            {
                returnValue = YES;
            }
        }
        
        *stop = returnValue;
    }];
    
    return returnValue;
}

+(BOOL)isEqualVerison:(NSString *)sourVersion withDes:(NSString *)desVersion
{
    NSArray * sourArr = [sourVersion componentsSeparatedByString:@"."];
    NSArray * desArr = [desVersion componentsSeparatedByString:@"."];
    int sourInt, desInt;
    NSMutableString * sourStr = [[NSMutableString alloc] init];
    NSMutableString * desStr = [[NSMutableString alloc] init];
    
    if ([sourArr count] < [desArr count])
    {
        return YES;
    }
    else
    {
        
    }
    
    for (int i = 0; i < [sourArr count]; i ++)
    {
        [sourStr appendFormat:@"%@", [sourArr objectAtIndex:i]];
        [desStr appendFormat:@"%@", [desArr objectAtIndex:i]];
    }
    sourInt = [sourStr intValue];
    desInt = [desStr intValue];
    if (sourInt < desInt)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    return NO;
    
}


- (BOOL)isWhitespaceAndNewlines
{
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i)
    {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c])
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isStartsWith:(NSString *)str
{
    return [self isStartsWith:str Options:NSCaseInsensitiveSearch];
}

- (BOOL)isStartsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions
{
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length])
    && ([self rangeOfString:str options:compareOptions].location == 0);
}

- (BOOL)isEndsWith:(NSString *)str
{
    return [self isEndsWith:str Options:NSCaseInsensitiveSearch];
}

- (BOOL)isEndsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions
{
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length])
    && ([self rangeOfString:str options:(compareOptions | NSBackwardsSearch)].location == ([self length] - [str length]));
}

- (BOOL)isContainsString:(NSString *)str
{
    return [self isContainsString:str Options:NSCaseInsensitiveSearch];
}

- (BOOL)isContainsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions
{
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length]) && ([self rangeOfString:str options:compareOptions].location != NSNotFound);
}

#pragma mark - getMethod(得到相应的字符串)

- (NSString *)stringByTrimmingChar
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)removeWhiteSpace
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)removeNewLine
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
}


- (NSString *)sp_uppercaseFirstAlphabet
{
    if (self == nil || [self length] == 0) return self;
    return [[self substringToIndex:1].uppercaseString stringByAppendingString:[self substringFromIndex:1]];
}

- (NSString *)sp_substringWithRange:(NSRange)range
{
    if ([NSString isEmpty:self])
    {
        return nil;
    }
    
    if (range.location > self.length)
    {
        return nil;
    }
    
    if (range.location + range.length > self.length)
    {
        return nil;
    }
    
    return [self substringWithRange:range];
}


- (NSUInteger)sp_UTF8Length
{
    size_t length = strlen([self UTF8String]);
    return length;
}


#pragma mark - XML Extensions

-(NSString*)XMLString
{
    return [[self class] encodeXMLString:self];
}

-(NSString*)stringFromXMLString
{
    return [[self class] decodeXMLString:self];
}

+ (NSString *)encodeXMLString:(NSString *)source
{
    if (![source isKindOfClass:[NSString class]] || !source)
    {
        return @"";
    }
    
    NSString *result = [NSString stringWithString:source];
    
    if ([result rangeOfString:@"&"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&"] componentsJoinedByString:@"&amp;"];
    }
    
    if ([result rangeOfString:@"<"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"<"] componentsJoinedByString:@"&lt;"];
    }
    
    if ([result rangeOfString:@">"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@">"] componentsJoinedByString:@"&gt;"];
    }
    
    if ([result rangeOfString:@"\""].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"\""] componentsJoinedByString:@"&quot;"];
    }
    
    if ([result rangeOfString:@"'"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"'"] componentsJoinedByString:@"&apos;"];
    }
    
    return result;
}

+ (NSString *)decodeXMLString:(NSString *)source
{
    if (![source isKindOfClass:[NSString class]] || !source)
    {
        return @"";
    }
    
    NSString *result = [NSString stringWithString:source];
    
    if ([result rangeOfString:@"&amp;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&amp;"] componentsJoinedByString:@"&"];
    }
    
    if ([result rangeOfString:@"&lt;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&lt;"] componentsJoinedByString:@"<"];
    }
    
    if ([result rangeOfString:@"&gt;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&gt;"] componentsJoinedByString:@">"];
    }
    
    if ([result rangeOfString:@"&quot;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&quot;"] componentsJoinedByString:@"\""];
    }
    
    if ([result rangeOfString:@"&apos;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&apos;"] componentsJoinedByString:@"'"];
    }
    
    if ([result rangeOfString:@"&nbsp;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&nbsp;"] componentsJoinedByString:@" "];
    }
    
    if ([result rangeOfString:@"&#8220;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&#8220;"] componentsJoinedByString:@"\""];
    }
    
    if ([result rangeOfString:@"&#8221;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&#8221;"] componentsJoinedByString:@"\""];
    }
    
    if ([result rangeOfString:@"&#039;"].location != NSNotFound)
    {
        result = [[result componentsSeparatedByString:@"&#039;"] componentsJoinedByString:@"'"];
    }
    return result;
}

@end
