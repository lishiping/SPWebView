//
//  UIImage+SPBase64.m
//  jgdc
//
//  Created by lishiping on 2019/11/15.
//  Copyright © 2019 QingClass. All rights reserved.
//

#import "UIImage+SPBase64.h"
#import "NSData+SPBase64.h"


@implementation UIImage (SPBase64)

+(UIImage*)sp_imageWithBase64String:(NSString*)base64String
{
    return [[self alloc] sp_getImageWithBase64String:base64String];
}

-(UIImage*)sp_getImageWithBase64String:(NSString*)base64String
{
    base64String = [base64String sp_base64StringDeleteImagePrefix];
    NSData *data = [NSData dataFromBase64String:base64String];
    UIImage *image = [self initWithData:data];
    return image;
}

@end
