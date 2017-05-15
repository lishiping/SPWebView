//
//  LSPErrorView.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//

#import "LSPErrorView.h"
#import "SPWebView.h"

@implementation LSPErrorView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configureView];
    }
    return self;
}

- (void)configureView;
{
    NSBundle *bundle = [SPWebView bundleForName:@"SPWebView"];
    NSString *url =  [NSBundle pathForResource:@"reload_img@2x" ofType:@"png" inDirectory:bundle.bundlePath];
    UIImage *image = [UIImage imageWithContentsOfFile:url];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 75)];
    _imageView.image = image;
    [self addSubview:_imageView];

    _imageView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f-50);
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 20)];
    _titleLabel.text = @"点击重新加载";
//    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor lightGrayColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLabel];
    
    _titleLabel.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f);

    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelf:)]];
}

- (void)tapSelf:(UIGestureRecognizer*)reco;
{
    if (self.tapBlock)
    {
        self.tapBlock(reco);
    }
}

@end
