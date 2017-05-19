//
//  HMMenuView.h
//  HuanMoney
//
//  Created by weplus on 2017/1/6.
//  Copyright © 2017年 微加科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HMMenuArrowDirectionUp , // 上
    HMMenuArrowDirectionDown , // 下
    HMMenuArrowDirectionLeft , // 左
    HMMenuArrowDirectionRight // 右
} HMMenuArrowDirection;

@interface HMMenuView : UIView


/**
 画meun

 @param startPoint           开始的点
 @param margin               起始点与内容的margin
 @param fillColor              填充颜色
 @param strokeColor        边框的颜色
 @param arrowDirection   箭头的方位
 */
- (void)drawMenuWithStartPoint:(CGPoint)startPoint margin:(CGFloat)margin fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor arrowDirection:(HMMenuArrowDirection)arrowDirection;

@end
