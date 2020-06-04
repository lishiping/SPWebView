//
//  UIBarButtonItem+JItem.h
//  jgdc
//
//  Created by lishiping on 2019/11/26.
//  Copyright © 2019 QingClass. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef void (^SPIdBlock)(id object);

@interface UIBarButtonItem (JItem)

-(instancetype)initWithImage:(UIImage*)image color:(UIColor*)color click:(SPIdBlock)click;

@end

NS_ASSUME_NONNULL_END
