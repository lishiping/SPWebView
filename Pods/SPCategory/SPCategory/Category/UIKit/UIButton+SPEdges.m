//
//  UIButton+SPEdges.m
//
//  Created by lishiping on 17/4/2017.
//
//

#import "UIButton+SPEdges.h"

@implementation UIButton (SPEdges)

-(void)sp_makeLeftImageRightTitle:(CGFloat)spacing{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2, 0,spacing / 2);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, -spacing / 2);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
}

-(void)sp_makeLeftTitleRightImage:(CGFloat)spacing{
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat titleWidth = self.titleLabel.frame.size.width;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + spacing / 2 , 0,- titleWidth - spacing / 2);
    self.titleEdgeInsets = UIEdgeInsetsMake(0,- imageWidth - spacing / 2,0, imageWidth + spacing / 2);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
}

-(void)sp_makeTopImageBottomTitle:(CGFloat)gap{
    CGFloat imageHeight =  self.imageView.frame.size.height;
    CGFloat imageWidth = self.imageView.frame.size.width;
    
    CGFloat labelHeight = self.titleLabel.frame.size.height;
    CGFloat labelWidth = self.titleLabel.frame.size.width;
    
    // 这里都计算完毕了，很简单，例如 imageWidth是A  labelWidth是B
    // 那么image要居中就要X轴移动 （A+B）/2 - A/2
    // label要居中就要X轴移动 （A+B）/2 - B/2
    // Y轴移动就直接除以2 然后加上间隙就好了
    // 图片中心对齐控件XY轴的偏移量
    CGFloat imageOffSetX = labelWidth / 2;
    CGFloat imageOffSetY = imageHeight / 2 + gap / 2;
    CGFloat labelOffSetX = imageWidth / 2;
    CGFloat labelOffSetY = labelHeight / 2 + gap / 2;
    
    // 让UIButton能保证边缘自适应 居中的时候需要
    // 当上下排布的时候，要根据edge来填充content大小
    CGFloat maxWidth = MAX(imageWidth,labelWidth); // 上下排布宽度肯定变小 获取最大宽度的那个
    CGFloat changeWidth = imageWidth + labelWidth - maxWidth; // 横向缩小的总宽度
    CGFloat maxHeight = MAX(imageHeight,labelHeight); // 获取最大高度那个 （就是水平默认排布的时候的原始高度）
    CGFloat changeHeight = imageHeight + labelHeight + gap - maxHeight; // 总高度减去原始高度就是纵向宽大宗高度
    self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffSetY, imageOffSetX, imageOffSetY, -imageOffSetX);
    self.titleEdgeInsets = UIEdgeInsetsMake(labelOffSetY, -labelOffSetX, -labelOffSetY, labelOffSetX);
    self.contentEdgeInsets = UIEdgeInsetsMake(changeHeight - labelOffSetY, - changeWidth / 2, labelOffSetY, -changeWidth / 2);
}

-(void)sp_makeTopTitleBottomImage:(CGFloat)gap{
    CGFloat imageHeight =  self.imageView.frame.size.height;
    CGFloat imageWidth = self.imageView.frame.size.width;
    
    CGFloat labelHeight = self.titleLabel.frame.size.height;
    CGFloat labelWidth = self.titleLabel.frame.size.width;
    
    CGFloat imageOffSetX = labelWidth / 2;
    CGFloat imageOffSetY = imageHeight / 2 + gap / 2;
    CGFloat labelOffSetX = imageWidth / 2;
    CGFloat labelOffSetY = labelHeight / 2 + gap / 2;
    
    // 让UIButton能保证边缘自适应 居中的时候需要
    // 当上下排布的时候，要根据edge来填充content大小
    CGFloat maxWidth = MAX(imageWidth,labelWidth); // 上下排布宽度肯定变小 获取最大宽度的那个
    CGFloat changeWidth = imageWidth + labelWidth - maxWidth; // 横向缩小的总宽度
    CGFloat maxHeight = MAX(imageHeight,labelHeight); // 获取最大高度那个 （就是水平默认排布的时候的原始高度）
    CGFloat changeHeight = imageHeight + labelHeight + gap - maxHeight; // 总高度减去原始高度就是纵向宽大宗高度
    self.imageEdgeInsets = UIEdgeInsetsMake(imageOffSetY, imageOffSetX, -imageOffSetY, -imageOffSetX);
    self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffSetY, -labelOffSetX, labelOffSetY, labelOffSetX);
    self.contentEdgeInsets = UIEdgeInsetsMake(labelOffSetY, -changeWidth / 2, changeHeight - labelOffSetY, -changeWidth / 2);
}

@end
