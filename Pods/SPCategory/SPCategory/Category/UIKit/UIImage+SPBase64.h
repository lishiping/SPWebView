//
//  UIImage+SPBase64.h
//  jgdc
//
//  Created by lishiping on 2019/11/15.
//  Copyright © 2019 QingClass. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SPBase64)

+(UIImage*)sp_imageWithBase64String:(NSString*)base64String;

-(UIImage*)sp_getImageWithBase64String:(NSString*)base64String;

@end

NS_ASSUME_NONNULL_END
