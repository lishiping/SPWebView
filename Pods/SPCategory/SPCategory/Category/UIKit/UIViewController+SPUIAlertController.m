//
//  UIViewController+SPUIAlertController.m
//  SPCategory
//
//  Created by shiping1 on 2017/11/21.
//  Copyright © 2017年 lishiping. All rights reserved.
//

#import "UIViewController+SPUIAlertController.h"
#import <objc/runtime.h>


@implementation UIViewController (SPUIAlertController)

#pragma mark - AlertView

-(UIAlertController *)sp_showAlertView_title:(NSString*)title
                                    ok_title:(NSString*)ok_title
                                    ok_block:(SPIdClickedBlock)ok_block
{
    return [self sp_showAlertView_title:title message:nil animated:YES ok_title:ok_title ok_block:ok_block completion:nil];
}

-(UIAlertController *)sp_showAlertView_title:(NSString*)title
                                     message:(NSString*)message
                                    ok_title:(NSString*)ok_title
                                    ok_block:(SPIdClickedBlock)ok_block
{
    return [self sp_showAlertView_title:title message:message animated:YES ok_title:ok_title ok_block:ok_block completion:nil];
}

-(UIAlertController *)sp_showAlertView_title:(NSString*)title
                                     message:(NSString*)message
                                    animated: (BOOL)flag
                                    ok_title:(NSString*)ok_title
                                    ok_block:(SPIdClickedBlock)ok_block
                                  completion:(void (^ __nullable)(void))completion
{
    return  [self sp_showAlertView_title:title message:message ok_title:ok_title cancel_title:nil animated:flag ok_block:ok_block cancel_block:nil completion:completion];
}

-(UIAlertController *)sp_showAlertView_title:(NSString*)title
                                     message:(NSString*)message
                                    ok_title:(NSString*)ok_title
                                cancel_title:(NSString*)cancel_title
                                    ok_block:(SPIdClickedBlock)ok_block
                                cancel_block:(SPIdClickedBlock)cancel_block
{
    return [self sp_showAlertView_title:title message:message ok_title:ok_title cancel_title:cancel_title animated:YES ok_block:ok_block cancel_block:cancel_block completion:nil];
}

-(UIAlertController *)sp_showAlertView_title:(NSString*)title
                                     message:(NSString*)message
                                    ok_title:(NSString *)ok_title
                                cancel_title:(NSString *)cancel_title
                                    animated:(BOOL)animated
                                    ok_block:(SPIdClickedBlock)ok_block
                                cancel_block:(SPIdClickedBlock)cancel_block
                                  completion:(void (^ _Nullable)(void))completion

{
    //标题和信息必须有一个，这样才不会显示空白信息，
    //确定和取消按钮也必须有一个,这样信息显示完要有消失的功能
    //如果不满足则不弹出警告框
    if (([title isKindOfClass:[NSString class]]||[message isKindOfClass:[NSString class]]) && ([ok_title isKindOfClass:[NSString class]] || [cancel_title isKindOfClass:[NSString class]]))
    {
        //UIAlertController是ios8提出的代替alertView的类，和block结合比代理的方式更好
        UIAlertController *spAlertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [self sp_setObject:spAlertVC forAssociatedKey:@"spAlertVC"];
        
        if (ok_title.length>0) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:ok_title style:UIAlertActionStyleDefault handler:ok_block];
//            [okAction setValue:[UIColor commonColor0x43C6AC] forKey:@"titleTextColor"];
            [spAlertVC addAction:okAction];
        }
        
        if (cancel_title.length>0) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel_title style:UIAlertActionStyleCancel handler:cancel_block];
//            [cancelAction setValue:[UIColor commonColor0x43C6AC] forKey:@"titleTextColor"];
            [spAlertVC addAction:cancelAction];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:spAlertVC animated:animated completion:completion];
        });
        
        return spAlertVC;
    }
    
    return nil;
}

#pragma mark - ActionSheet
-(UIAlertController *)sp_showActionSheet_title:(NSString*_Nullable)title
                                       message:(NSString*_Nullable)message
                                      ok_title:(NSString*_Nullable)ok_title
                                  cancel_title:(NSString*_Nullable)cancel_title
                                      ok_block:(SPIdClickedBlock _Nullable)ok_block
                                  cancel_block:(SPIdClickedBlock _Nullable)cancel_block
{
    return [self sp_showActionSheet_title:title message:message ok_title:ok_title cancel_title:cancel_title animated:YES ok_title_style:UIAlertActionStyleDestructive ok_block:ok_block cancel_block:cancel_block completion:nil];
}

-(UIAlertController *)sp_showActionSheet_title:(NSString*_Nullable)title
                                       message:(NSString*_Nullable)message
                          ok_title_destructive:(NSString*_Nullable)ok_title_destructive
                                  cancel_title:(NSString*_Nullable)cancel_title
                                      ok_block:(SPIdClickedBlock _Nullable)ok_block
                                  cancel_block:(SPIdClickedBlock _Nullable)cancel_block
{
    return [self sp_showActionSheet_title:title message:message ok_title:ok_title_destructive cancel_title:cancel_title animated:YES ok_title_style:UIAlertActionStyleDestructive ok_block:ok_block cancel_block:cancel_block completion:nil];
}

-(UIAlertController *)sp_showActionSheet_title:(NSString*_Nullable)title
                                       message:(NSString*_Nullable)message
                              ok_title_default:(NSString*_Nullable)ok_title_default
                                  cancel_title:(NSString*_Nullable)cancel_title
                                      ok_block:(SPIdClickedBlock _Nullable)ok_block
                                  cancel_block:(SPIdClickedBlock _Nullable)cancel_block
{
    return [self sp_showActionSheet_title:title message:message ok_title:ok_title_default cancel_title:cancel_title animated:YES ok_title_style:UIAlertActionStyleDefault ok_block:ok_block cancel_block:cancel_block completion:nil];
}

-(UIAlertController *)sp_showActionSheet_title:(NSString *)title
                                       message:(NSString * _Nullable)message
                                      ok_title:(NSString * _Nullable)ok_title
                                  cancel_title:(NSString * _Nullable)cancel_title
                                      animated:(BOOL)animated
                                ok_title_style:(UIAlertActionStyle)ok_title_style
                                      ok_block:(SPIdClickedBlock _Nullable)ok_block
                                  cancel_block:(SPIdClickedBlock _Nullable)cancel_block
                                    completion:(void (^ _Nullable)(void))completion

{
    //标题和信息可无，参照微信中有这么做的
    //确定和取消按钮必须都有这样才能有选择
    //如果不满足则不弹出警告框
    
    if ([ok_title isKindOfClass:[NSString class]] && [cancel_title isKindOfClass:[NSString class]])
    {
        UIAlertController *spAlertVC = [UIAlertController alertControllerWithTitle:title?:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [self sp_setObject:spAlertVC forAssociatedKey:@"spAlertVC"];
        
        if (ok_title.length>0) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:ok_title style:ok_title_style handler:ok_block];
            [spAlertVC addAction:okAction];
        }
        
        if (cancel_title.length>0) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel_title style:UIAlertActionStyleCancel handler:cancel_block];
            [spAlertVC addAction:cancelAction];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:spAlertVC animated:animated completion:completion];
        });
        
        return spAlertVC;
    }
    
    return nil;
}

-(void)sp_removespAlertVC
{
    id obj = [self sp_objectWithAssociatedKey:@"spAlertVC"];
    if ([obj isKindOfClass:[UIAlertController class]])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [obj dismissViewControllerAnimated:NO completion:nil];
            [self sp_removeAssociatedObjects];
        });
    }
}


@end
