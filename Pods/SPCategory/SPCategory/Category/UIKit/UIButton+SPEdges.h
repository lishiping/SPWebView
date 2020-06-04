//
//  UIButton+SPEdges.h
//
//  Created by lishiping on 17/4/2017.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (SPEdges)

/// 控制按钮图片和文字位置及间距
/// @param padding 间距
-(void)sp_makeLeftImageRightTitle:(CGFloat)padding;
-(void)sp_makeLeftTitleRightImage:(CGFloat)padding;
-(void)sp_makeTopImageBottomTitle:(CGFloat)padding;
-(void)sp_makeTopTitleBottomImage:(CGFloat)padding;

@end
