//
//  SPFoundationMacro.h
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 16/11/11.
//  Copyright (c) 2016年 lishiping. All rights reserved.
//
//If you think this open source library is of great help to you, please open the URL to click the Star,your approbation can encourage me, the author will publish the better open source library for guys again
//如果您认为本开源库对您很有帮助，请打开URL给作者点个赞，您的认可给作者极大的鼓励，作者还会发布更好的开源库给大家

//github address//https://github.com/lishiping/SPWebView
//github address//https://github.com/lishiping/SPDebugBar
//github address//https://github.com/lishiping/SPFastPush
//github address//https://github.com/lishiping/SPMacro
//github address//https://github.com/lishiping/SafeData
//github address//https://github.com/lishiping/SPCategory
//github address//https://github.com/lishiping/SPBaseClass

#import "SPFoundationMacro.h"
#import <mach/mach_time.h>
#import <objc/runtime.h>

//#import <execinfo.h>


@interface SPFoundationMacro()

@end

@implementation SPFoundationMacro

//// 函数调用堆栈
//+(void)printBacktrace
//{
//    void *callstack[128] = {0};
//    int frameCount = backtrace(callstack, 128);
//    char **frameStrings = backtrace_symbols(callstack, frameCount);
//    if ( frameStrings != NULL ) {
//        // Start with frame 1 because frame 0 is PrintBacktrace()
//        for ( int i = 1; i < frameCount; i++ ) {
//            printf("%s\n", frameStrings[i]);
//            
//        }
//        free(frameStrings);
//    }
//}


+(void)printFatherClass:(id)obj
{
#if DEBUG
    printf("\n class:");
    Class cls = object_getClass(obj);
    while (cls)
    {
        printf(" %s -->", class_getName(cls));
        cls = class_getSuperclass(cls);
    }
    printf("\n");
#endif
}

/**
 计算代码执行时间的方法（相比其他方法要好一些）
 
 @param block 要执行的代码块
 
 @return 返回毫秒时间
 */
+(double)calculateRunTimeBlock:(void (^)(void))block
{
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return 0.0;
    
    uint64_t start = mach_absolute_time ();
    block();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;//得到纳秒

    double nanoTime =(double)nanos / NSEC_PER_MSEC;
    
    SP_LOG(@"%@=%.2fms",SP_LANGUAGE_IS_EN()?@"CODE EXECUTE_TIME":@"代码执行时间",nanoTime);
    
    return nanoTime; //计算结果是毫秒
}


+ (NSString *)sp_stringDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
@end





