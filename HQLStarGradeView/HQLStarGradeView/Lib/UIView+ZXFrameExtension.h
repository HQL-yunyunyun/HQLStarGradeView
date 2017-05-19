//
//  UIView+ZXFrameExtension.h
//  HuanMoney
//
//  Created by Xiang on 16/3/17.
//  Copyright © 2016年 微加科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZXFrameExtension)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize  size;

@end
/**
 1.@property如果不是写在分类中, 会自动生成
 1> 属性的setter\getter声明和实现
 2> _下划线开头的成员变量
 
 2.@property如果是写在分类中, 仅仅会自动生成
 1> 属性的setter\getter声明
 */