//
//  SPUIKitMacro.h
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

#import <UIKit/UIKit.h>


//----------------------screen size-------------------------
//----------------------屏幕尺寸-------------------------

#define SP_SCREEN_BOUND      ([UIScreen mainScreen].bounds)

#define SP_SCREEN_WIDTH      ([UIScreen mainScreen].bounds.size.width)

#define SP_SCREEN_HEIGHT     ([UIScreen mainScreen].bounds.size.height)

#define SP_SCREEN_SCALE      ([UIScreen mainScreen].scale)

#define SP_STATUSBAR_HEIGHT  (SP_IS_FULLSCREEN ? 44.f : 20.f)

#define SP_NAVIBAR_HEIGHT    44.f

#define SP_NAVIBAR_STATUSBAR_HEIGHT   (SP_STATUSBAR_HEIGHT+SP_NAVIBAR_HEIGHT)

#define SP_TABBAR_HEIGHT_NORMAL    49.f

#define SP_TABBAR_SAFE_BOTTOM_MARGIN   (SP_IS_FULLSCREEN ? 34.f : 0.f)

#define SP_TABBAR_HEIGHT    (SP_TABBAR_HEIGHT_NORMAL+SP_TABBAR_SAFE_BOTTOM_MARGIN)

//----------------Screen adaptation--------------------
//--------------------屏幕适配---------------------------

// Usually UI to design mark could not have a variety of screen when mark respectively, too much trouble, need only gives an annotation of the screen, then we selected by default if iPhone6 screen design, according to the proportion iPhone6 screen automatically adapt to the other screen

// iphone4 iphone 5 iPhone7 are in accordance with the (w = 375) coded as a benchmark rate adaptive
// 通常UI给设计图标注的时候不可能多种屏幕分别标注，太麻烦了，需要只给一种屏幕的标注就行，那么我们默认选中只要iPhone6屏幕的设计图标注，其他屏幕根据iPhone6屏幕比例自动适应

// iphone4 iphone5 iPhone7 都按照(w=375)标注为基准比例自适应
#define SP_ADJUST_WIDTH(width)    (floorf((width) * SP_SCREEN_WIDTH/ 375.0f))
//不需要等比例适配的建议使用下面的宏定义，防止传入非数值，也为了以后想要加适配的时候，只改宏定义函数就行了
#define SP_WIDTH(width)           (width)?:0

// iphone4 iphone 5 iPhone7 are in accordance with the (h=667) coded as a benchmark rate adaptive
// iphone4 iphone5 iPhone7 都按照(h=667)标注为基准比例自适应
#define SP_ADJUST_HEIGHT(height)  (floorf((height) * SP_SCREEN_HEIGHT/ 667.0f))
//不需要等比例适配的建议使用下面的宏定义，防止传入非数值，也为了以后想要加适配的时候，只改宏定义函数就行了
#define SP_HEIGHT(height)         (height)?:0


//---------------Judging device screen---------------------
//--------------------判断设备屏幕---------------------------

//判断是手机还是pad
#define SP_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SP_IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//iphone4,iphone4S的屏幕
#define SP_SCREEN_IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size) : NO)

//iphone5,iphone5S,iphone5C的屏幕
#define SP_SCREEN_IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size) : NO)

//iphone6，iPhone7，iPhone8的屏幕
#define SP_SCREEN_IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size): NO)

//iphone6P，iPhone7P，iPhone8P的屏幕
#define SP_SCREEN_IS_IPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size) : NO)

//iphoneX的屏幕
#define SP_SCREEN_IS_IPHONE_X_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(375, 812), [UIScreen mainScreen].bounds.size) : NO)

#define SP_SCREEN_IS_IPHONE_XR_XSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(414, 896), [UIScreen mainScreen].bounds.size) : NO)

//异性全面屏
#define SP_IS_FULLSCREEN    (SP_SCREEN_IS_IPHONE_X_XS || SP_SCREEN_IS_IPHONE_XR_XSMAX)

//iPad Air,iPad Air2,iPad Pro9.7inch,iPad Retina的屏幕
#define SP_SCREEN_IS_IPAD_AIR_AIR2_PRO9_RETINA ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [UIScreen mainScreen].bounds.size) : NO)

//iPad Pro12.9inch的屏幕
#define SP_SCREEN_IS_IPAD_PRO12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1024, 1366), [UIScreen mainScreen].bounds.size) : NO)

//--------------------Font---------------------------
//--------------------字体---------------------------

#define SP_FONT(size)                [UIFont systemFontOfSize:(size)]
#define SP_FONT_B(size)              [UIFont boldSystemFontOfSize:(size)]
#define SP_FONT_NAME_SIZE(name,size) [UIFont fontWithName:(name) size:(size)]

//细体字
#define SP_FONT_SIZE_LIGHT(size)     [UIFont systemFontOfSize:fontSize weight:UIFontWeightUltraLight];
//常规字
#define SP_FONT_SIZE_REGULAR(size)   [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
//粗体字
#define SP_FONT_SIZE_BOLD(size)      [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];

//-------------------Color---------------------------
//--------------------颜色---------------------------

#define SP_COLOR_RGB(r,g,b)        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SP_COLOR_RGBA(r,g,b,a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a/1.0]

//Hexadecimal color to color object
//16进制数转为颜色对象
//SP_COLOR_RGB(0X1E1E1E);
#define SP_COLOR_HEX_RGB(hexValue) [UIColor colorWith\
Red     :(hexValue & 0xFF0000)     / (float)0xFF0000 \
green   :(hexValue & 0xFF00)       / (float)0xFF00 \
blue    :(hexValue & 0xFF)         / (float)0xFF \
alpha   :1.0]

//16进制数转为颜色对象带透明度
//SP_COLOR_RGBA(0X1E1E1E);
#define SP_COLOR_HEX_RGBA(hexValue) [UIColor colorWith\
Red     :(hexValue & 0xFF000000)  / (float)0xFF000000 \
green   :(hexValue & 0xFF0000)    / (float)0xFF0000 \
blue    :(hexValue & 0xFF00)      / (float)0xFF00 \
alpha   :(hexValue & 0xFF)        / (float)0xFF]

//Hexadecimal string color to the color object
//16进制字符串颜色转为颜色对象
//SP_COLOR_HEX(@"#1E1E1E");
#define SP_COLOR_HEX_STR(hexstring) [SPUIKitMacro colorWithHexString:hexstring alpha:1.0f]
#define SP_COLOR_HEXA_STR(hexstring,alpha) [SPUIKitMacro colorWithHexString:hexstring alpha:alpha]


//--------------------image---------------------------
//--------------------图片---------------------------

#define SP_IMAGE(name)              [UIImage imageNamed:(name)]
#define SP_IMAGE_VIEW(name)         [[UIImageView alloc] initWithImage:SP_IMAGE(name)]

#define SP_IMAGE_FILE(file)         [UIImage imageWithContentsOfFile:file]
#define SP_IMAGE_DATA(data)         [UIImage imageWithData:(data)]

//view to image
//根据视图截屏
#define SP_IMAGE_CAPTURE(view)      [SPUIKitMacro captureWithView:view];

//获取指定大小的图片，等比例
#define SP_IMAGE_COMPRESS(image,size)  [SPUIKitMacro compressImage:image toSize:size];

//获取图片根据给定颜色
#define SP_IMAGE_BY_COLOR(color)    [SPUIKitMacro createImageWithColor:color];


//--------------------AlertView---------------------------
//--------------------警告框---------------------------

//#define SP_SHOW_ALERT(message,cancelTitle)   SP_SHOW_ALERTVIEW(0, nil, (message), nil, cancelTitle?:@"确定", nil)
//
//#define SP_SHOW_ALERTVIEW(_tag_, title, msg, _delegate_, cancelTitle, ...) {\
//UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title\
//message: msg\
//delegate: _delegate_\
//cancelButtonTitle: cancelTitle\
//otherButtonTitles: __VA_ARGS__];\
//alert.tag = _tag_;\
//[alert show];\
//}


//--------------------iOS Version---------------------
//--------------------iOS 版本---------------------------

//判断是否等于某版本
//SP_iOS_SYSTEM_VERSION_EQUAL_TO(@"8.0")
#define SP_iOS_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

//判断是否大于某版本
#define SP_iOS_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

//判断是否大于等于某版本
#define SP_iOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//判断是否小于某版本
#define SP_iOS_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

//判断是否小于等于某版本
#define SP_iOS_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//获取系统版本字符串
#define SP_iOS_VERSION_STRING  [[UIDevice currentDevice] systemVersion]

//以下判断准确可用
#define SP_iOS6_OR_LATER  SP_iOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")
#define SP_iOS7_OR_LATER  SP_iOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define SP_iOS8_OR_LATER  SP_iOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define SP_iOS9_OR_LATER  SP_iOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define SP_iOS10_OR_LATER SP_iOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")
#define SP_iOS11_OR_LATER SP_iOS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")


//--------------------打印---------------------------

//遍历子视图打印指针地址
#define SP_PRINT_AllVIEW(view)        [SPUIKitMacro printAllViews:view]

//-----------------------------------------------

@interface SPUIKitMacro : NSObject

/**
 16进制#开头的字符串颜色转为颜色对象
 
 @param color 16进制字符串
 
 @return 颜色对象
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 打印当前视图名称和指针地址以及子视图的遍历打印
 
 @param view 当前视图
 */
+ (void)printAllViews:(UIView *)view;


+ (UIImage*)createImageWithColor:(UIColor *)color;

/**
 视图转为图片
 
 @param view 视图对象
 
 @return 图片对象
 */
+ (UIImage *)captureWithView:(UIView *)view;

/**
 *  获取指定大小的图片，保存原图片比例
 *
 *  @param size  指定大小
 *
 *  @return 符合要求的图片
 */
+ (UIImage *)compressImage:(UIImage*)image toSize:(CGSize)size;

@end

