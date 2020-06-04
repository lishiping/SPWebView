//
//  UIImage+SPGIF.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
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


#import "UIImage+SPGIF.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (SPGIF)


+ (UIImage *)sp_animatedGIFNamed:(NSString *)name
{
    NSString *retinaPath = @"";
    if ([name hasSuffix:@".gif"]) {
        retinaPath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    }
    else
    {
        retinaPath = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    }
    
    NSData *data = [NSData dataWithContentsOfFile:retinaPath];
    
    if (data) {
        return [UIImage sp_animatedGIFWithData:data];
    }
    
    return [UIImage imageNamed:name];
}

+ (UIImage *)sp_animatedGIFWithData:(NSData *)data
{
    if ([data isKindOfClass:[NSData class]])
    {
        CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
        size_t count = CGImageSourceGetCount(source);
        
        UIImage *animatedImage;
        
        if (count <= 1)
        {
            animatedImage = [[UIImage alloc] initWithData:data];
        }
        else
        {
            NSMutableArray *images = [NSMutableArray array];
            NSTimeInterval duration = 0.0f;
            
            for (size_t i = 0; i < count; i++) {
                CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
                
                duration += [self sp_frameDurationAtIndex:i source:source];
                
                [images addObject:[UIImage imageWithCGImage:image]];
                
                CGImageRelease(image);
            }
            
            if (!duration) {
                duration = (1.0f / 10.0f) * count;
            }
            
            animatedImage = [UIImage animatedImageWithImages:images duration:duration];
        }
        
        CFRelease(source);
        
        return animatedImage;
    }
    
    return nil;
}

+ (UIImage *)sp_animatedGIFWithData:(NSData *)data scale:(CGFloat)scale
{
    if ([data isKindOfClass:[NSData class]])
    {
        CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
        size_t count = CGImageSourceGetCount(source);
        
        UIImage *animatedImage;
        
        if (count <= 1)
        {
            animatedImage = [[UIImage alloc] initWithData:data scale:scale];
        }
        else
        {
            NSMutableArray *images = [NSMutableArray array];
            NSTimeInterval duration = 0.0f;
            
            for (size_t i = 0; i < count; i++)
            {
                CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
                
                duration += [self sp_frameDurationAtIndex:i source:source];
                
                [images addObject:[UIImage imageWithCGImage:image scale:scale orientation:UIImageOrientationUp]];
                
                CGImageRelease(image);
            }
            
            if (!duration) {
                duration = (1.0f / 10.0f) * count;
            }
            
            animatedImage = [UIImage animatedImageWithImages:images duration:duration];
        }
        
        CFRelease(source);
        
        return animatedImage;
    }
    
    return nil;
}

+ (float)sp_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp)
    {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else
    {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

- (UIImage *)sp_animatedImageByScalingAndCroppingToSize:(CGSize)size
{
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero))
    {
        return self;
    }
    
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    }
    else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    
    NSMutableArray *scaledImages = [NSMutableArray array];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    for (UIImage *image in self.images) {
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        [scaledImages addObject:newImage];
    }
    
    UIGraphicsEndImageContext();
    
    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}

@end
