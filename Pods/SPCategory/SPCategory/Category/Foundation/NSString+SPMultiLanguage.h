//
//  NSString+SPMultiLanguage.h
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


/*
 *  1.本类是关于读取多语言的工具方法，主要对于模块化使用
    2.请在重新设置本地语言的时候，重新修改[[NSUserDefaults standardUserDefaults] integerForKey:@"MulanguageSet"]的值，中文简体设置0，中文繁体设置1，英文设置为2
 */
/*!
 *  NSString 关于读取多语言的工具方法
 */
@interface NSString (SPMultiLanguage)
/*!
 *  取得当前MulanguageSet
 *
 *  @return 返回当前MulanguageSet
 */
NSInteger currentLanguageCode();

/**
 *  清除当前语言字典
 */
void clearLanguageDic();

/*!
 *  获取对应多语言的字符串
 *
 *  @param keyLanguage 取得对应语言的key
 *  @param keyValue    nil
 *
 *  @return 对应多语言的字符串
 */
#define loadMuLanguage(keyLanguage,modulename) \
  _loadMuLanguage((keyLanguage),nil,modulename)

NSString* _loadMuLanguage(NSString *keyLanguage,NSString *keyValue,NSString *modulename);

/*!
 *  读取多语言字符串，有换行标记的进行换行
 *
 *  @param keyLanguage 取得对应语言的key
 *  @param keyValue    nil
 *
 *  @return 对应多语言的字符串
 */
#define loadMuLanguageEscape(keyLanguage,keyValue) \
        _loadMuLanguageEscape((keyLanguage),(keyValue),nil)

NSString* _loadMuLanguageEscape(NSString *keyLanguage, NSString *keyValue, NSString *modulename);

@end
