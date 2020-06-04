//
//  NSObject+SPTypeOfClass.h
//  SPCategory
//
//  Created by lishiping on 2019/9/2.
//  Copyright © 2019 lishiping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SPTypeOfClass)

/*
 1.数据类型简便判断方法，
 2.针对不可变做了非空判断,因为不可变里面要有内容才能继续使用
 3.可变没有做非空判断，因为可变空数据可以增加的，所以通常初始化可变空数据，然后添加内容
 */
-(BOOL)sp_isString;
-(BOOL)sp_isMutableString;

-(BOOL)sp_isArray;
-(BOOL)sp_isMutableArray;

-(BOOL)sp_isDictionary;
-(BOOL)sp_isMutableDictionary;

-(BOOL)sp_isNumber;

-(BOOL)sp_isData;

@end

NS_ASSUME_NONNULL_END
