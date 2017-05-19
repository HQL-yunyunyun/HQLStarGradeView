//
//  HMMenuView.m
//  HuanMoney
//
//  Created by weplus on 2017/1/6.
//  Copyright © 2017年 微加科技. All rights reserved.
//

#import "HMMenuView.h"
#import "UIView+ZXFrameExtension.h"

@interface HMMenuView ()

@property (strong, nonatomic) CAShapeLayer *currentLayer;

@end

@implementation HMMenuView

- (void)drawMenuWithStartPoint:(CGPoint)startPoint margin:(CGFloat)margin fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor arrowDirection:(HMMenuArrowDirection)arrowDirection {
    [self.currentLayer removeFromSuperlayer];
    self.currentLayer.fillColor = fillColor.CGColor;
    self.currentLayer.strokeColor = strokeColor.CGColor;
    
    CGFloat lineWidth = margin * 0.1;
    self.currentLayer.lineWidth = lineWidth < 0.2 ? 0.2 : (lineWidth > 1 ? 1 : lineWidth);
    
    self.backgroundColor = [UIColor clearColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    switch (arrowDirection) {
        case HMMenuArrowDirectionUp: {
            [self drawUpOrDownPath:path isUp:YES startPoint:startPoint margin:margin];
            break;
        }
        case HMMenuArrowDirectionDown: {
            [self drawUpOrDownPath:path isUp:NO startPoint:startPoint margin:margin];
            break;
        }
        case HMMenuArrowDirectionLeft: {
            [self drawLeftOrRightPath:path isLeft:YES startPoint:startPoint margin:margin];
            break;
        }
        case HMMenuArrowDirectionRight: {
            [self drawLeftOrRightPath:path isLeft:NO startPoint:startPoint margin:margin];
            break;
        }
    }
    self.currentLayer.path = path.CGPath;
    [self.layer insertSublayer:self.currentLayer atIndex:0];
}

- (void)drawUpOrDownPath:(UIBezierPath *)path isUp:(BOOL)yesOrNo startPoint:(CGPoint)point margin:(CGFloat)margin {
    CGFloat width = self.width - 2 * margin;
    CGFloat height = self.height - 2 * margin;
    CGFloat arrowWidth = margin * 0.5;
    
    CGFloat leftMargin = 0;
    CGFloat rightMargin = 0;
    if (point.x == self.width * 0.5) {
        // 在中点
        leftMargin = arrowWidth * 0.5;
        rightMargin = leftMargin;
    } else if (point.x < self.width * 0.5) {
        // 在左边
        leftMargin = 0;
        rightMargin = arrowWidth;
    } else {
        // 在右边
        leftMargin = arrowWidth;
        rightMargin = 0;
    }
    
    CGFloat sign = yesOrNo ? -1 : 1;
    
    [path addLineToPoint:CGPointMake(point.x - leftMargin, point.y + (margin * sign))];
    [path addLineToPoint:CGPointMake(margin, point.y + (margin * sign))];
    [path addLineToPoint:CGPointMake(margin, point.y + (margin * sign + height * sign))];
    [path addLineToPoint:CGPointMake(margin + width, point.y + margin * sign + height * sign)];
    [path addLineToPoint:CGPointMake(margin + width, point.y + margin * sign)];
    [path addLineToPoint:CGPointMake(point.x + rightMargin, point.y + margin * sign)];
    [path closePath];
}

- (void)drawLeftOrRightPath:(UIBezierPath *)path isLeft:(BOOL)yesOrNo startPoint:(CGPoint)point margin:(CGFloat)margin {
    CGFloat width = self.width - 2 * margin;
//    CGFloat height = self.height - 2 * margin;
    CGFloat arrowWidth = margin * 0.5;
    
    CGFloat upMargin = 0;
    CGFloat downMargin = 0;
    if (point.x == self.width * 0.5) {
        // 在中点
        upMargin = arrowWidth * 0.5;
        downMargin = upMargin;
    } else if (point.x < self.width * 0.5) {
        // 在左边
        upMargin = 0;
        downMargin = arrowWidth;
    } else {
        // 在右边
        upMargin = arrowWidth;
        downMargin = 0;
    }
    
    CGFloat sign = yesOrNo ? -1 : 1;
    
    [path addLineToPoint:CGPointMake(point.x + margin * sign, point.y + downMargin)];
    [path addLineToPoint:CGPointMake(point.x + margin * sign, self.height - margin)];
    [path addLineToPoint:CGPointMake(point.x + margin * sign + width * sign, self.height - margin)];
    [path addLineToPoint:CGPointMake(point.x + margin * sign + width * sign, margin)];
    [path addLineToPoint:CGPointMake(point.x + margin * sign, margin)];
    [path addLineToPoint:CGPointMake(point.x + margin * sign, point.y - upMargin)];
    [path closePath];
}

- (CAShapeLayer *)currentLayer {
    if (!_currentLayer) {
        _currentLayer = [CAShapeLayer new];
        _currentLayer.frame = self.bounds;
        _currentLayer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor;
        _currentLayer.shadowOffset = CGSizeMake(5, 5);
        _currentLayer.shadowOpacity = 0.5;
    }
    return _currentLayer;
}

@end
