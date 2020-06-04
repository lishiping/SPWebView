//  NSString+SPBase64.h
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

//NSString相关的Base64
@interface NSString (SPBase64)

//从base64转为utf8编码的String
+(NSString *)stringFromBase64String:(NSString *)base64String;
//从base64URL转为utf8编码的String
+(NSString *)stringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;

//从utf8编码的String转为base64
-(NSString *)base64String;
//从utf8编码的String转为base64URL
-(NSString *)base64UrlEncodedString;

//NSData转为base64的NSString
+(NSString *)base64StringFromData:(NSData *)data;
//从base64转为base64URL
+(NSString *)base64UrlEncodedStringFromBase64String:(NSString *)base64String;
//从base64URL转为base64
+(NSString *)base64StringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;


@end

//NSData相关的Base64
@interface NSData (SPBase64)

//从base64转为data
+(NSData *)dataFromBase64String:(NSString *)base64String;
//从base64URl转为data
+(NSData *)dataFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;

//从data转为base64
-(NSString *)base64String;
//从data转为base64URL
-(NSString *)base64UrlEncodedString;


@end
