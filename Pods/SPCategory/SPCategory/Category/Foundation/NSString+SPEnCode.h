//
//  NSString+SPEncode.h
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


#import <Foundation/Foundation.h>

@interface NSString (SPEnCode)

#pragma mark - enCode(编码)

//转为data编码为UTF8
- (NSData *)toDataUTF8;
//转为data指定编码模式
- (NSData *)toDataUsingEncoding:(NSStringEncoding)encoding;

//得到md5加密字符
- (NSString *)md5;
+ (NSString *)md5String:(NSString *)str;

//转换为表情字符
- (NSString *)emojiString;

//将url的字符串编码后返回字符串,
//lishiping://login?title=你好&username=lishiping&password=123456
//转化为
//lishiping://login?title=%e4%bd%a0%e5%a5%bd&username=lishiping&password=123456
-(NSURL*)getURLByurlEncode;
-(NSString*)getStringByurlEncode;

//将url的字符串解码后返回字符串
//lishiping://login?title=%e4%bd%a0%e5%a5%bd&username=lishiping&password=123456
//转化为
//lishiping://login?title=你好&username=lishiping&password=123456
-(NSURL*)getURLByurlDecode;
-(NSString*)getStringByurlDecode;

//从url字符串中得到编码后的请求参数
-(NSDictionary*)getParamFromURLByurlEncode;
//从url字符串得到解码后的请求参数
-(NSDictionary*)getParamFromURLByurlDecode;

//对字典请求参数排序并生成带地址符的字符串，排序是为了计算md5值的时候顺序正确
- (NSString *)stringForHTTPBySortParameters:(NSDictionary*)param;

//将字符串以URL格式编码
- (NSString *)urlEncode;
//字符串从URL格式解码
- (NSString *)urlDecode;


//将字符串以XML格式编码
-(NSString*)XMLString;
+ (NSString *)encodeXMLString:(NSString *)source;

//从XML格式解码
-(NSString*)stringFromXMLString;
+ (NSString *)decodeXMLString:(NSString *)source;


#pragma mark - judge(判断)

//是否为空
+ (BOOL)isEmpty:(NSString *)string;

// 是否带有表情符号
- (BOOL)isContainsEmoji;

/**
 compare two version（判断两个字符串是否为同一系统版本）
 @param sourVersion 9.0.2
 @param desVersion 9.2.1
 @returns No,sourVersion is less than desVersion; YES, the statue is opposed
 */
+(BOOL)isEqualVerison:(NSString *)sourVersion withDes:(NSString *)desVersion;

//判断当前字符串是否只包含空白字符和换行符
- (BOOL)isWhitespaceAndNewlines;

//判断是否以给定字符串开始,忽略大小写
- (BOOL)isStartsWith:(NSString *)str;
//判断是否以给定字符串开始,忽略大小写，指定条件
- (BOOL)isStartsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

//判断是否以给定字符串结束，忽略大小写
- (BOOL)isEndsWith:(NSString *)str;
//判断是否以给定字符串结束，忽略大小写，指定条件
- (BOOL)isEndsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

//判断是否包含给定的字符串, 忽略大小写
- (BOOL)isContainsString:(NSString *)str;
//判断是否包含给定的字符串, 忽略大小写，指定条件
- (BOOL)isContainsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions;


#pragma mark - getMethod(得到相应的字符串)

//去除字符串前后的空白,不包含换行符
- (NSString *)stringByTrimmingChar;

//去除字符串中所有空白
- (NSString *)removeWhiteSpace;

//去除字符串中所有换行符
- (NSString *)removeNewLine;

//大写字符串中第一个字符
- (NSString *)sp_uppercaseFirstAlphabet;

//获得固定范围的子串
- (NSString *)sp_substringWithRange:(NSRange)range;

//获得UTF8编码后的长度
- (NSUInteger)sp_UTF8Length;


@end
