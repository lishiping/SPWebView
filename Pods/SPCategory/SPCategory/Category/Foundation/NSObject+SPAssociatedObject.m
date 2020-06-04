//
//  NSObject+WBTAssociatedObject.m
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


#import "NSObject+SPAssociatedObject.h"

@implementation NSObject (SPAssociatedObject)

- (id)sp_objectWithAssociatedKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

- (void)sp_removeObjectforAssociatedKey:(void *)key
{
    objc_setAssociatedObject(self, key, nil,OBJC_ASSOCIATION_ASSIGN);
}

- (void)sp_removeAssociatedObjects
{
    objc_removeAssociatedObjects(self);
}

- (void)sp_setObject:(id)object forAssociatedKey:(void *)key
{
    objc_setAssociatedObject(self, key, object,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sp_setObject:(id)object forAssociatedKey:(void *)key retained:(BOOL)retain
{
    objc_setAssociatedObject(self, key, object, retain?OBJC_ASSOCIATION_RETAIN_NONATOMIC:OBJC_ASSOCIATION_ASSIGN);
}

- (void)sp_setObject:(id)object forAssociatedKey:(void *)key associationPolicy:(objc_AssociationPolicy)policy
{
    objc_setAssociatedObject(self, key, object, policy);
}

@end
