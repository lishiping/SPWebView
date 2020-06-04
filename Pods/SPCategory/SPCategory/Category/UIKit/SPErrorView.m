//
//  SPErrorView.m
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//

#import "SPErrorView.h"
#import <SPMacro/SPMacro.h>

@interface SPErrorView ()

@property (nonatomic, copy) SPButtonClickedBlock button1_click_block;
@property (nonatomic, copy) SPButtonClickedBlock button2_click_block;

@end

@implementation SPErrorView

#pragma mark - 带有icon和title的错误页
-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title block:(SPButtonClickedBlock)block
{
    self = [super initWithFrame:frame];
    [self configureView_image:image title:title];
    self.button1_click_block = block;
    return self;
}


- (void)configureView_image:(UIImage*)image title:(NSString*)title
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.image = image;
    [self addSubview:imageView];
    
    imageView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f-25.0f);
    
    if (title.length>0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 20)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLabel];
        
        titleLabel.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f+image.size.height/2.0f);
    }
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelf:)]];
}

- (void)tapSelf:(UIGestureRecognizer*)reco;
{
    if (self.button1_click_block)
    {
        self.button1_click_block(reco);
    }
}


#pragma mark - 两个按钮的错误页

-(instancetype)initWithFrame:(CGRect)frame
                       image:(UIImage *)image
                       title:(NSString *)title
                    subtitle:(NSString *)subtitle
               button1_title:(NSString *)button1_title
               button2_title:(NSString *)button2_title
         button1_click_block:(SPButtonClickedBlock)button1_click_block
         button2_click_block:(SPButtonClickedBlock)button2_click_block
{
    self = [super initWithFrame:frame];
    [self configureView_image:image title:title subtitle:subtitle button1_title:button1_title button2_title:button2_title];
    self.button1_click_block = button1_click_block;
    self.button2_click_block = button2_click_block;
    return self;
}

- (void)configureView_image:(UIImage*)image title:(NSString*)title subtitle:(NSString *)subtitle
              button1_title:(NSString *)button1_title
              button2_title:(NSString *)button2_title
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.image = image;
    [self addSubview:imageView];
    
    imageView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f-150.0f);
    
    if (title.length>0) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 20)];
        titleLabel.text = title;
        titleLabel.backgroundColor = [UIColor clearColor];
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = SP_COLOR_HEX_STR(@"#5A626D");
        titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:titleLabel];
        
        titleLabel.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f-150.0f+image.size.height/2.0f+15.0f);
    }
    
    if (subtitle.length>0) {
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 20)];
        subtitleLabel.text = subtitle;
        subtitleLabel.backgroundColor = [UIColor clearColor];
        
        subtitleLabel.textAlignment = NSTextAlignmentCenter;
        subtitleLabel.textColor = SP_COLOR_HEX_STR(@"#969FA9");
        subtitleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:subtitleLabel];
        
        subtitleLabel.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f-150.0f+image.size.height/2.0f+15.0f+25.0f);
    }
    
    if (button1_title.length>0 && button2_title.length >0) {
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitle:button1_title forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
        button1.frame = CGRectMake(CGRectGetWidth(self.frame)/2.0f-104-15, CGRectGetHeight(self.frame)/2.0f-150.0f+image.size.height/2.0f+15.0f+18.0f+50.0, 104, 38);
        [button1 setTitleColor:SP_COLOR_HEX_STR(@"#5A626D") forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:16];
        button1.backgroundColor = [UIColor whiteColor];
        button1.layer.cornerRadius = 19;
        button1.layer.borderWidth = 1;
        button1.layer.borderColor = SP_COLOR_HEX_STR(@"#969FA9").CGColor;
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setTitle:button2_title forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
        button2.frame = CGRectMake(CGRectGetWidth(self.frame)/2.0f+15, CGRectGetHeight(self.frame)/2.0f-150.0f+image.size.height/2.0f+15.0f+18.0f+50.0, 104, 38);
        [button2 setTitleColor:SP_COLOR_HEX_STR(@"#5A626D") forState:UIControlStateNormal];
        button2.titleLabel.font = [UIFont systemFontOfSize:16];
        button2.backgroundColor = [UIColor whiteColor];
        button2.layer.cornerRadius = 19;
        button2.layer.borderWidth = 1;
        button2.layer.borderColor = SP_COLOR_HEX_STR(@"#969FA9").CGColor;
        
        [self addSubview:button1];
        [self addSubview:button2];
    }
}

- (void)button1Click:(UIButton*)button;
{
    if (self.button1_click_block)
    {
        self.button1_click_block(button);
    }
}

- (void)button2Click:(UIButton*)button;
{
    if (self.button2_click_block)
    {
        self.button2_click_block(button);
    }
}


@end
