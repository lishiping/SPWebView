// BlockDefine.h
//  e-mail:83118274@qq.com

// Copyright 2014 lishiping, Inc. All rights reserved.

//If you think this open source library is of great help to you, please open the URL to click the Star,your approbation can encourage me, the author will publish the better open source library for guys again
//如果您认为本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory
//github address//https://github.com/lishiping/SPBaseClass

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//A single param（一个参数）
typedef void (^SPIntBlock)(int intVar);
typedef void (^SPLongBlock)(long longVar);
typedef void (^SPLongLongBlock)(long long longlongVar);
typedef void (^SPFloatBlock)(float floatVar);
typedef void (^SPDoubleBlock)(double doubleVar);
typedef void (^SPVoidBlock)(void);
typedef void (^SPIndexPathBlock)(NSIndexPath* indexPath);
typedef void (^SPIntegerBlock)(NSInteger integer);
typedef void (^SPCGFloatBlock)(CGFloat cgfloat);
typedef void (^SPIdBlock)(id object);
typedef void (^SPBOOLBlock)(BOOL boolVar);
typedef void (^SPArrayBlock)(NSArray* array);
typedef void (^SPDataBlock)(NSData* data);
typedef void (^SPImageBlock)(UIImage* image);
typedef void (^SPStringBlock)(NSString* string);
typedef void (^SPDictionaryBlock)(NSDictionary* dict);

//double params（两个参数）
typedef void (^SPIdErrorBlock)(id object, NSError *error);
typedef void (^SPBOOLErrorBlock)(BOOL boolVar, NSError *error);
typedef void (^SPIntegerErrorBlock)(NSInteger number, NSError *error);
typedef void (^SPLongErrorBlock)(long longVar, NSError *error);
typedef void (^SPLongLongErrorBlock)(long long longlongVar, NSError *error);
typedef void (^SPFloatErrorBlock)(float floatVar, NSError *error);
typedef void (^SPDoubleErrorBlock)(double doubleVar, NSError *error);
typedef void (^SPArrayErrorBlock)(NSArray* array, NSError *error);
typedef void (^SPDataErrorBlock)(NSData* data, NSError *error);
typedef void (^SPImageErrorBlock)(UIImage* image, NSError *error);
typedef void (^SPStringErrorBlock)(NSString* string, NSError *error);
typedef void (^SPDictionaryErrorBlock)(NSDictionary* dict, NSError *error);


