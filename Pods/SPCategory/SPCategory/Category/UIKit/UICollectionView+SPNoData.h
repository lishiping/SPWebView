//
//  UICollectionView+SPNoData.h
//  jgdc
//
//  Created by lishiping on 2019/10/9.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBlockDefine.h"
#import "UIView+SPFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (SPNoData)

//可定制的无数据视图 默认为显示暂无数据label
//居中显示
@property(nonatomic,strong)UIView   *sp_nodataView;

//开启自动显示隐藏无数据视图 根据协议返回的section个数以及item个数联合判断
@property(nonatomic,assign)BOOL     sp_autoShowNoData;


/**
 设置无数据页的图片和标题

 @param image 图片
 @param title 标题
 @param block 点击无数据页回调
 */
-(void)sp_nodataViewImage:(UIImage*)image title:(NSString*)title block:(nullable SPIdBlock)block;

/**
 扩展方法设置无数据页

 @param image 图片
 @param title 标题
 @param frame 位置大小
 @param backgroundColor 背景色
 @param block 点击回调
 */
-(void)sp_nodataViewImage:(UIImage*)image title:(NSString*)title frame:(CGRect)frame backgroundColor:(UIColor*)backgroundColor block:(nullable SPIdBlock)block;

/**
 手动控制是否展示
 */
- (void)sp_showNoDataView;
/**
 手动移除
 */
- (void)sp_removeNoDataView;

@end

NS_ASSUME_NONNULL_END
