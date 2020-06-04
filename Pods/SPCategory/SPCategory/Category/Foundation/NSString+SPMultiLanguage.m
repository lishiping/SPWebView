//
//  NSString+SPMultiLanguage.m
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

#import "NSString+SPMultiLanguage.h"

@implementation NSString (SPMultiLanguage)
static NSDictionary *dicLanguage = nil;

NSInteger currentLanguageCode()
{
    NSInteger lanSet = [[NSUserDefaults standardUserDefaults] integerForKey:@"MulanguageSet"];
    return lanSet;
}

void clearLanguageDic()
{
    dicLanguage = nil;
}

NSString* _loadMuLanguage(NSString *keyLanguage,NSString *keyValue,NSString *modulename)
{
    NSInteger lanSet = [[NSUserDefaults standardUserDefaults] integerForKey:@"MulanguageSet"];
    
    if (!dicLanguage)
    {
        switch (lanSet)
        {
            case 0: {
                NSDictionary *dicLan = [[NSDictionary alloc] initWithContentsOfFile:
                                        [[NSBundle mainBundle] pathForResource:@"language_ch" ofType:@"plist"]];
                dicLanguage = dicLan;
                break;
            }
            case 1: {
                NSString *language_path = @"language_tw";
                NSDictionary *dicLantw = [[NSDictionary alloc] initWithContentsOfFile:
                                          [[NSBundle mainBundle] pathForResource:language_path ofType:@"plist"]];
                dicLanguage = dicLantw;
                break;
            }
            case 2: {
                NSString *  language_path = @"language_english";
                NSDictionary *dicLanen = [[NSDictionary alloc] initWithContentsOfFile:
                                          [[NSBundle mainBundle] pathForResource:language_path ofType:@"plist"]];
                dicLanguage = dicLanen;
                break;
            }
                
            default:
                break;
        }
    }
    NSString *strValue;
    
    if ((lanSet == 2 || lanSet == 1) && modulename.length>0 && [[dicLanguage objectForKey:modulename] objectForKey:keyLanguage])
    {
        strValue = [[dicLanguage objectForKey:modulename] objectForKey:keyLanguage];
    }
    else
    {
        strValue = [dicLanguage objectForKey:keyLanguage];
    }
    
    if (strValue == nil) {
        return keyLanguage;
    } else {
        return strValue;
    }
}

NSString* _loadMuLanguageEscape(NSString *keyLanguage, NSString *keyValue, NSString *modulename)
{
    NSString *string = _loadMuLanguage(keyLanguage, keyValue, modulename);
    return [string stringByReplacingOccurrencesOfString:@"{NEW_LINE}" withString:@"\n"];
}

@end
