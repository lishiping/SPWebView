//
//  SPFastPush.m
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

#import "SPFastPush.h"

@interface SPFastPush ()
{
}

@end

@implementation SPFastPush


#pragma mark - push & pop

+(UIViewController *)pushVCWithClassName:(NSString *)vcClassName params:(NSDictionary *)params animated:(BOOL)animated
{
    //创建当前类并加入属性
    UIViewController *ret = [[self class] createVC:vcClassName withParams:params];
    
    [[self class] pushVC:ret animated:animated];
    
    return (ret);
}

+ (BOOL)pushVC:(UIViewController *)vc animated:(BOOL)animated
{
    NSAssert([vc isKindOfClass:[UIViewController class]], @"vc is not VC");
    
    if ([vc isKindOfClass:[UIViewController class]])
    {
        //find NavigationController
        UINavigationController *navc = [[self class] getCurrentNavC];
        
        if (navc)
        {
            if (navc.viewControllers.count)
            {
                vc.hidesBottomBarWhenPushed = YES;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [navc pushViewController:vc animated:animated];
            });
            return YES;
        }
    }
    return NO;
}

+ (BOOL)popToLastVCWithAnimated:(BOOL)animated
{
    UINavigationController *navc = [[self class] getCurrentNavC];
    if (navc && navc.viewControllers.count>1)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [navc popViewControllerAnimated:animated];
        });
        return YES;
    }
    return NO;
}

+ (BOOL)popToRootVCWithAnimated:(BOOL)animated
{
    UINavigationController *navc = [[self class] getCurrentNavC];
    if (navc && navc.viewControllers.count>1)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [navc popToRootViewControllerAnimated:animated];
        });
        return YES;
    }
    return NO;
}

+ (BOOL)popToVCAtIndex:(NSInteger)index animated:(BOOL)animated
{
    UINavigationController *navc = [[self class] getCurrentNavC];
    
    NSAssert(navc && index>=0 && navc.viewControllers.count>1 && navc.viewControllers.count-1>index, @"can not pop!!!");
    
    //导航栈内一定要超过1个vc，否则不能pop
    //从导航栈顶跳到栈顶不成立，所以navc.viewControllers.count-1>index
    if (navc && index>=0 && navc.viewControllers.count>1 && navc.viewControllers.count-1>index)
    {
        UIViewController *obj = [navc.viewControllers objectAtIndex:index];
        
        NSAssert([obj isKindOfClass:[UIViewController class]], @"obj is not VC");
        
        if (obj)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [navc popToViewController:obj animated:animated];
            });
            return YES;
        }
    }
    return NO;
}

+ (BOOL)popToVCWithClassName:(NSString *)className animated:(BOOL)animated
{
   UIViewController *vcobj =[self navigationStackHas:className];
    UINavigationController *navc = [self getCurrentNavC];

    if (vcobj && navc)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [navc popToViewController:vcobj animated:animated];
        });
        return YES;
    }
    
    return NO;
}

+ (id)navigationStackHas:(NSString *)className
{
    NSAssert([className isKindOfClass:[NSString class]] && className.length>0, @"className string error!");
    
    if ([className isKindOfClass:[NSString class]] && className.length>0)
    {
        NSString *name = [className stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        Class cls = NSClassFromString(name);
        
        if (cls && [cls isSubclassOfClass:[UIViewController class]])
        {
            UINavigationController *navc = [[self class] getCurrentNavC];
            
            //导航栈内一定要超过1个vc，否则不能pop
            if (navc && navc.viewControllers.count>1)
            {
                NSArray *vcArr = navc.viewControllers;
                
                for (UIViewController *vcobj in vcArr) {
                    
                    if ([vcobj isMemberOfClass:[cls class]])
                    {
                        return vcobj;
                    }
                }
            }
        }
    }
    
    return nil;
}

#pragma mark - present & dismiss

+(UIViewController *)presentVC:(NSString *)vcClassName params:(NSDictionary *)params animated:(BOOL)animated
{
    //创建当前类并加入属性
    UIViewController *ret = [[self class] createVC:vcClassName withParams:params];
    
    [[self class] presentVC:ret animated:animated completion:nil];
    
    return  ret;
}

+(void)presentVC:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion
{
    NSAssert([vc isKindOfClass:[UIViewController class]], @"vc is not VC");
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        
        UIViewController *topVC = [[self class] topVC];
        
        if (topVC) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [topVC presentViewController:vc animated:animated completion:completion];
            });
        }
    }
}

+(void)rootVCpresentVC:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion
{
    NSAssert([vc isKindOfClass:[UIViewController class]], @"vc is not VC");
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        
        UIViewController *rootVC = [[self class] rootVC];
        
        if (rootVC) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [rootVC presentViewController:vc animated:animated completion:completion];
            });
        }
    }
}

+ (void)dismissVCAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *vc = [[self class] getPresentingVC];
    if (vc)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:animated completion:completion];
        });
    }
}

#pragma mark - create VC object

+ (UIViewController *)createVC:(NSString *)className withParams:(NSDictionary *)params
{
    UIViewController *ret = nil;
    
    NSAssert(([className isKindOfClass:[NSString class]] && className.length>0), @"className string error!");
    
    if ([className isKindOfClass:[NSString class]] && className.length>0)
    {
        NSString *name = [className stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        Class cls = NSClassFromString(name);
        
        NSAssert((cls && [cls isSubclassOfClass:[UIViewController class]]), @"class is not ViewController");
        
        if (cls && [cls isSubclassOfClass:[UIViewController class]]) {
            
            // create viewController
            UIViewController *vc = [[cls alloc] init];
            
            // kvc set params;
            ret = [[self class] object:vc kvc_setParams:params];
        }
    }
    return (ret);
}

+ (id)object:(id)object kvc_setParams:(NSDictionary *)params;
{
    if ([params isKindOfClass:[NSDictionary class]] && (params.count>0))
    {
        @try {
            [object setValuesForKeysWithDictionary:params];
        } @catch (NSException *exception) {
            NSAssert(nil, exception.description);
        } @finally {
        }
    }
    
    return object;
}

#pragma mark - get VC
+(UINavigationController *)getCurrentNavC
{
    UINavigationController *navc = [[self class] topVC].navigationController;
    
    NSAssert([navc isKindOfClass:[UINavigationController class]], @"navc is not UINavigationController");
    
    return ([navc isKindOfClass:[UINavigationController class]] ? navc : nil);
}

+(UIViewController *)getPresentingVC
{
    UIViewController *ret = nil;
    UIViewController *topVC = [[self class] topVC];
    if (topVC.presentingViewController) {
        ret = topVC.presentingViewController;
    }
    
    if (!ret) {
        
        if (topVC.navigationController) {
            UIViewController *tempVC  =  topVC.navigationController.presentingViewController;
            
            if (tempVC) {
                ret = tempVC;
            }
        }
    }
    
    NSAssert([ret isKindOfClass:[UINavigationController class]],nil);
    
    return ret;
}

+ (UIViewController *)topVC
{
    UIViewController *ret = nil;
    UIViewController *vc = [[self class] rootVC];
    while (vc) {
        ret = vc;
        if ([ret isKindOfClass:[UINavigationController class]])
        {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if ([ret isKindOfClass:[UITabBarController class]])
        {
            vc = [(UITabBarController *)vc selectedViewController];
        } else
        {
            vc = [vc presentedViewController];
        }
    }
    
    NSAssert([ret isKindOfClass:[UIViewController class]],nil);
    
    return ([ret isKindOfClass:[UIViewController class]] ? ret : nil);
}

+ (UIViewController *)rootVC
{
    UIViewController  *vc = [[self class] mainWindow].rootViewController;
    
    NSAssert([vc isKindOfClass:[UIViewController class]],nil);
    
    return (vc);
}

+ (UIWindow*)mainWindow
{
    UIWindow *window = nil;
    
    UIApplication *app  = [UIApplication sharedApplication];
    
    if ([app.delegate respondsToSelector:@selector(window)]) {
        window = [app.delegate window];
    }
    
    if (!window) {
        if ([app windows].count>0)
        {
            window = [[app windows] objectAtIndex:0];
        }
    }
    
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    return window;
}

+ (UITabBarController *)getCurrentTabVC
{
    UITabBarController *tab = (UITabBarController *)[[self class] rootVC];
    
    NSAssert([tab isKindOfClass:[UITabBarController class]],nil);
    
    return ([tab isKindOfClass:[UITabBarController class]] ? tab : nil);
}

+ (BOOL)currentTabVCSetToSelectIndex:(NSUInteger)selectIndex
{
    UITabBarController *tab = [[self class] getCurrentTabVC];
    
    if (tab && tab.viewControllers.count>selectIndex)
    {
        tab.selectedIndex = selectIndex;
        return YES;
    }
    return NO;
}

#pragma mark - APP Open URL

+(void)appOpenURLString:(NSString *)urlString option:(NSDictionary*)option completionHandler:(void (^ __nullable)(BOOL success))completion
{
    if ([urlString isKindOfClass:[NSString class]] && urlString.length>0) {
        [self appOpenURL:[NSURL URLWithString:urlString] option:option completionHandler:completion];
    }
}

+(void)appOpenURL:(NSURL *)url option:(NSDictionary*)option completionHandler:(void (^)(BOOL success))completion
{
    if (url && [[UIApplication sharedApplication] canOpenURL:url])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[UIDevice currentDevice].systemVersion floatValue]>=10.0f)
            {
                [[UIApplication sharedApplication] openURL:url options:option completionHandler:completion];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        });
    }
}

/*
 注意：
 
 1.iOS10及以后prefs前缀不再生效，APP—Prefs前缀可用
 2.iOS10之前两个前缀都可用,但是prefs可以到达详细的页面，例如可以直接到达定位的开关
 3.iOS11及以后prefs前缀不再生效，APP—Prefs前缀跳转只能到系统的设置页，不能到设置里面的具体页面
 
 要跳转的设置界面    URL String
 WIFI    App-Prefs:root=WIFI
 Bluetooth    App-Prefs:root=Bluetooth
 蜂窝移动网络    App-Prefs:root=MOBILE_DATA_SETTINGS_ID
 个人热点    App-Prefs:root=INTERNET_TETHERING
 VPN    App-Prefs:root=VPN
 运营商    App-Prefs:root=Carrier
 通知    App-Prefs:root=NOTIFICATIONS_ID
 定位服务    App-Prefs:root=Privacy&path=LOCATION
 通用    App-Prefs:root=General
 关于本机    App-Prefs:root=General&path=About
 键盘    App-Prefs:root=General&path=Keyboard
 辅助功能    App-Prefs:root=General&path=ACCESSIBILITY
 语言与地区    App-Prefs:root=General&path=INTERNATIONAL
 还原    App-Prefs:root=General&path=Reset
 墙纸    App-Prefs:root=Wallpaper
 Siri    App-Prefs:root=SIRI
 隐私    App-Prefs:root=Privacy
 Safari    App-Prefs:root=SAFARI
 音乐    App-Prefs:root=MUSIC
 照相与照相机    App-Prefs:root=Photos
 FaceTime    App-Prefs:root=FACETIME
 电池电量    App-Prefs:root=BATTERY_USAGE
 存储空间    App-Prefs:root=General&path=STORAGE_ICLOUD_USAGE/DEVICE_STORAGE
 显示与亮度    App-Prefs:root=DISPLAY
 声音设置    App-Prefs:root=Sounds
 App Store    App-Prefs:root=STORE
 iCloud    App-Prefs:root=CASTLE
 语言设置    App-Prefs:root=General&path=INTERNATIONAL
 
 
 蜂窝网络：prefs:root=MOBILE_DATA_SETTINGS_ID
 VPN — prefs:root=General&path=Network/VPN
 Wi-Fi：prefs:root=WIFI
 定位服务：prefs:root=LOCATION_SERVICES
 个人热点：prefs:root=INTERNET_TETHERING
 关于本机：prefs:root=General&path=About
 辅助功能：prefs:root=General&path=ACCESSIBILITY
 飞行模式：prefs:root=AIRPLANE_MODE
 锁定：prefs:root=General&path=AUTOLOCK
 亮度：prefs:root=Brightness
 蓝牙：prefs:root=General&path=Bluetooth
 时间设置：prefs:root=General&path=DATE_AND_TIME
 FaceTime：prefs:root=FACETIME
 设置：prefs:root=General
 键盘设置：prefs:root=General&path=Keyboard
 iCloud：prefs:root=CASTLEiCloud
 备份：prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 语言：prefs:root=General&path=INTERNATIONAL
 定位：prefs:root=LOCATION_SERVICES
 音乐：prefs:root=MUSICMusic
 Equalizer — prefs:root=MUSIC&path=EQMusic
 Volume Limit — prefs:root=MUSIC&path=VolumeLimit
 Network — prefs:root=General&path=Network
 Nike + iPod — prefs:root=NIKE_PLUS_IPOD
 Notes — prefs:root=NOTES
 Notification — prefs:root=NOTIFICATIONS_ID
 Phone — prefs:root=Phone
 Photos — prefs:root=Photos
 Profile —prefs:root=General&path=ManagedConfigurationList
 Reset — prefs:root=General&path=Reset
 Safari — prefs:root=Safari
 Siri — prefs:root=General&path=Assistant
 Sounds — prefs:root=Sounds
 Software Update —prefs:root=General&path=SOFTWARE_UPDATE_LINK
 Store — prefs:root=STORET
 witter — prefs:root=TWITTER
 Usage — prefs:root=General&path=USAGE
 Wallpaper — prefs:root=Wallpaper
 
 */

////打开系统通知
//+(void)appOpenSystemSettingNotification
//{
//    //ios10之前可以直接跳到具体页面
//    NSString *urlString = @"prefs:root=NOTIFICATIONS_ID";
//    if ([UIDevice currentDevice].systemVersion.floatValue>=10.0f) {
//        //ios10之后只能跳到设置页面
//        urlString = @"App-Prefs:root=NOTIFICATIONS_ID";
//    }
//
//    [self appOpenURLString:urlString option:@{} completionHandler:nil];
//}
//
////打开系统定位
//+(void)appOpenSystemSettingLocation
//{
//    //ios10之前可以直接跳到定位的具体页面
//    NSString *urlString = @"prefs:root=LOCATION_SERVICES";
//    if ([UIDevice currentDevice].systemVersion.floatValue>=10.0f) {
//        //ios10之后只能跳到设置页面
//        urlString = @"App-Prefs:root=LOCATION_SERVICES";
//    }
//
//    [self appOpenURLString:urlString option:@{} completionHandler:nil];
//}
//
////打开系统设置
//+(void)appOpenSystemSetting
//{
//    NSString *urlString = @"prefs:root";
//    if ([UIDevice currentDevice].systemVersion.floatValue>=8.0f) {
//        urlString = UIApplicationOpenSettingsURLString;
//    }
//
//    [self appOpenURLString:urlString option:@{} completionHandler:nil];
//}
//
////调取系统拨打电话
//+(void)appOpenTelPhone:(NSString *)phoneNumber needAlert:(BOOL)isNeedAlert
//{
//    if ([phoneNumber isKindOfClass:[NSString class]] && phoneNumber.length > 0)
//    {
//        NSString *tel = [NSString stringWithFormat:(isNeedAlert ? @"telprompt://%@" : @"tel://%@"), phoneNumber];
//        [[self class] appOpenURLString:tel option:nil completionHandler:nil];
//    }
//}


@end


