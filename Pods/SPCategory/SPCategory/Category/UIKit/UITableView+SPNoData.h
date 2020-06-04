//
//  UITableView+SPNoData.h
//  jgdc
//
//  Created by lishiping on 2019/10/9.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBlockDefine.h"

NS_ASSUME_NONNULL_BEGIN

/**
 帮助tableview自动显示无数据页
 */
@interface UITableView (SPNoData)

//可定制的无数据视图 默认为显示暂无数据label
//居中显示
@property(nonatomic,strong)UIView  *sp_nodataView;

//自动显示隐藏无数据视图 根据协议返回的section个数以及cell个数联合判断，以及section的header以及footer只要有高度就认为有数据 （默认为NO，需要手动调用showNoDataView显示
@property(nonatomic,assign)BOOL    sp_autoShowNoData;

//当开启自动显示无数据功能，设置这个参数可以只计算cell个数联合判断 （默认为NO计算cell和section都要判断）
@property(nonatomic,assign)BOOL    sp_onlyNumberOfRowsInSection;

/**
 设置无数据页

 @param image 图片
 @param title 标题
 @param block 点击回调
 */
-(void)sp_nodataViewImage:(UIImage*)image title:(NSString*)title block:(nullable SPIdBlock)block;

/**
 扩展设置无数据页

 @param image 图片
 @param title 标题
 @param frame 位置大小
 @param backgroundColor 背景色
 @param block 点击回调
 */
-(void)sp_nodataViewImage:(UIImage*)image title:(NSString*)title frame:(CGRect)frame backgroundColor:(UIColor*)backgroundColor block:(nullable SPIdBlock)block;

/**
 手动显示无数据页
 */
- (void)sp_showNoDataView;

/**
 手动移除无数据页
 */
- (void)sp_removeNoDataView;

@end

NS_ASSUME_NONNULL_END
