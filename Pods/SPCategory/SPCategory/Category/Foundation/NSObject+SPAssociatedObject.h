//
//  NSObject+WBTAssociatedObject.h
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
#import <objc/runtime.h>

/*!
    本来是快捷使用runtime的关联对象功能
 *  添加 NSObject 设置和获取关联对象的类别方法。
 */
@interface NSObject (SPAssociatedObject)

/*!
 *  获取当前对象对应key的关联对象
 *
 *  @param key 关联对象key
 *
 *  @return 对应key的关联对象
 */
- (id)sp_objectWithAssociatedKey:(void *)key;

/**
 绑定完关联对象一定要移除，否则容易造成强引用而内存泄漏

 @param key 移除指定关联对象的key
 */
- (void)sp_removeObjectforAssociatedKey:(void *)key;

/**
 移除当前对象所有的关联对象（不建议使用，谨慎使用）
 */
- (void)sp_removeAssociatedObjects;

/**
 设置关联对象的对应key，默认（OBJC_ASSOCIATION_RETAIN_NONATOMIC）

 enum {
 OBJC_ASSOCIATION_ASSIGN = 0, //弱引用，对象销毁不会造成关联对象的引用计数变化
 OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, //强引用，不支持多线程安全
 OBJC_ASSOCIATION_COPY_NONATOMIC = 3, //深拷贝，不支持多线程安全
 OBJC_ASSOCIATION_RETAIN = 01401, //强引用支持线程安全
 OBJC_ASSOCIATION_COPY = 01403  //深拷贝，支持线程安全
 };
 
 @param object 关联对象
 @param key 关联对象对应key
 */
- (void)sp_setObject:(id)object forAssociatedKey:(void *)key;

/*!
 *  设置关联对象的对应key
 *
 *  @param object 关联对象
 *  @param key    关联对象对应key
 *  @param retain 是否要retain该对象
 */
- (void)sp_setObject:(id)object forAssociatedKey:(void *)key retained:(BOOL)retain;

/*!
 *  设置关联对象给对应key
 *
 *  @param object 关联对象
 *  @param key    关联对象对应key
 *  @param policy AssociationPolicy
 */
- (void)sp_setObject:(id)object forAssociatedKey:(void *)key associationPolicy:(objc_AssociationPolicy)policy;

@end
