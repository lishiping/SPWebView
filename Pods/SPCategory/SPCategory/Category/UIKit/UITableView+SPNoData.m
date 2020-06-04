//
//  UITableView+SPNoData.m
//  jgdc
//
//  Created by lishiping on 2019/10/9.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "UITableView+SPNoData.h"
#import <objc/runtime.h>
#import "UIView+SPAction.h"
#import "UIView+SPFrame.h"

@implementation UITableView (SPNoData)

+ (void)load{
    Method reloadData    = class_getInstanceMethod(self, @selector(reloadData));
    Method sp_reloadData = class_getInstanceMethod(self, @selector(sp_reloadData));
    method_exchangeImplementations(reloadData, sp_reloadData);
}

- (void)sp_reloadData{
    [self sp_reloadData];
    [self checkData];
}

- (void)checkData{
    if (self.sp_autoShowNoData) {
        BOOL haveData = NO;
        //如果可以执行组方法，说明绑定了DataSource
        if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
        {
          NSInteger section= [self.dataSource numberOfSectionsInTableView:self];
            //当组数大于零的时候，判断行数是否大于零
            if (section>0) {
                for (int i = 0; i<section; i++) {
                    if ([self.dataSource tableView:self numberOfRowsInSection:i]>0) {
                        haveData = YES;
                        break;
                    }
                }
                //当只计算行的时候，不判断组头和组尾
                if (!self.sp_onlyNumberOfRowsInSection) {
                    //增加判断组头的高度，如果有高度也是有数据的
                    for (int i = 0; i<section; i++) {
                        if ([self.delegate tableView:self heightForHeaderInSection:section]>0) {
                            haveData = YES;
                            break;
                        }
                    }
                    //增加判断组尾的高度，如果有高度也是有数据的
                    for (int i = 0; i<section; i++) {
                        if ([self.delegate tableView:self heightForFooterInSection:section]>0) {
                            haveData = YES;
                            break;
                        }
                    }
                }
            }
        }else if([self.dataSource tableView:self numberOfRowsInSection:0]>0){
            haveData = YES;
        }
        
        if (haveData) {
            [self sp_removeNoDataView];
        }else{
            [self sp_showNoDataView];
        }
    }
}

- (UIView *)sp_nodataView
{
    return objc_getAssociatedObject(self, @selector(sp_nodataView));
}
- (void)setSp_nodataView:(UIView *)sp_nodataView
{
    objc_setAssociatedObject(self, @selector(sp_nodataView), sp_nodataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setSp_autoShowNoData:(BOOL)sp_autoShowNoData
{
    objc_setAssociatedObject(self, @selector(sp_autoShowNoData), @(sp_autoShowNoData), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadData];
}

- (BOOL)sp_autoShowNoData
{
    return [objc_getAssociatedObject(self, @selector(sp_autoShowNoData)) boolValue];
}

-(void)setSp_onlyNumberOfRowsInSection:(BOOL)sp_onlyNumberOfRowsInSection
{
    objc_setAssociatedObject(self, @selector(sp_onlyNumberOfRowsInSection), @(sp_onlyNumberOfRowsInSection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadData];
}
-(BOOL)sp_onlyNumberOfRowsInSection
{
    return [objc_getAssociatedObject(self, @selector(sp_onlyNumberOfRowsInSection)) boolValue];
}

-(void)sp_nodataViewImage:(UIImage*)image title:(NSString*)title block:(SPIdBlock)block{
    return [self sp_nodataViewImage:image title:title frame:self.bounds backgroundColor:UIColor.whiteColor block:block];
}

-(void)sp_nodataViewImage:(UIImage*)image title:(NSString*)title frame:(CGRect)frame backgroundColor:(UIColor*)backgroundColor block:(SPIdBlock)block
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    view.userInteractionEnabled = YES;

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.image = image;
    [view addSubview:imageView];
    
    imageView.center = CGPointMake(view.sp_width/2.0f, view.sp_height/2.0f-25.0f);
    
    if (title.length>0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.sp_width, 20)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:titleLabel];
        
        titleLabel.center = CGPointMake(view.sp_width/2.0f, view.sp_height/2.0f+image.size.height/2.0f);
    }
    
    [view sp_view_onClickBlock:^(id object) {
        if (block) {
            block(object);
        }
    }];
    
    self.sp_nodataView = view;
}

- (void)sp_showNoDataView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self sp_removeNoDataView];
        if (self.sp_nodataView) {
            [self addSubview:self.sp_nodataView];
        }
    });
}

- (void)sp_removeNoDataView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.sp_nodataView removeFromSuperview];
    });
}

@end
