//
//  LSPErrorView.h
//  e-mail:83118274@qq.com
//
//  Created by lishiping on 17/4/25.
//  Copyright © 2017年 lishiping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClickedBlock)(id sender);

@interface LSPErrorView : UIView

@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, copy) ButtonClickedBlock tapBlock;

@end
