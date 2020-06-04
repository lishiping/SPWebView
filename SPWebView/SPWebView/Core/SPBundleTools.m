//
//  SPBundleTools.m
//
//  Created by lishiping on 2019/6/28.
//  Copyright © 2019 lishiping. All rights reserved.
//

#import "SPBundleTools.h"

@implementation SPBundleTools

+ (UIImage *)getPngImageBundle:(NSString *)bundleName imageName:(NSString *)name {
   return [self getImageBundle:bundleName imageName:name type:@"png"];
}

+ (UIImage *)getImageBundle:(NSString *)bundleName imageName:(NSString *)name type:(NSString *)type
{
    NSBundle *b1 = [self getBundleForName:bundleName];
    NSString *p = nil;
    if ([UIScreen mainScreen].scale == 3) {
        p = [b1 pathForResource:[name stringByAppendingString:@"@3x"] ofType:type];
    }else{
        p = [b1 pathForResource:[name stringByAppendingString:@"@2x"] ofType:type];
    }
    
    if (!p) {
        p = [b1 pathForResource:name ofType:type];
    }
    return [UIImage imageWithContentsOfFile:p];
}

+ (NSDictionary *)getJsonBundle:(NSString *)bundleName jsonName:(NSString *)name {
    NSBundle *b1 = [self getBundleForName:bundleName];
    NSString *p = [b1 pathForResource:name ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:p encoding:NSUTF8StringEncoding error:nil];
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)getPathBundle:(NSString *)bundleName fileName:(NSString *)name
{
    NSBundle *b = [NSBundle bundleForClass:self];
    NSURL *url = [b URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *b1 = [NSBundle bundleWithURL:url];
    NSString *p = [b1 pathForResource:name ofType:nil];
    return p;
}

+ (NSData *)getDataBundle:(NSString *)bundleName fileName:(NSString *)name
{
    NSBundle *b1 = [self getBundleForName:bundleName];
    NSString *p = nil;
    p = [b1 pathForResource:name ofType:nil];
    return [NSData dataWithContentsOfFile:p];
}

+ (NSBundle *)getMainBundle
{
    NSBundle *b = [NSBundle mainBundle];
    return b;
}

+ (NSBundle *)getBundleForName:(NSString *)bundleName
{
//    NSString *pathComponent = [NSString stringWithFormat:@"%@.bundle", bundleName];
//    NSString *bundlePath =[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:pathComponent];
//    NSBundle *customizedBundle = [NSBundle bundleWithPath:bundlePath];
//    return customizedBundle;
    
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    NSURL *url = [b URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *b1 = [NSBundle bundleWithURL:url];
    return b1;
}




@end
