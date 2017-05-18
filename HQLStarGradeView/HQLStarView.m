//
//  HQLStartView.m
//  HQLStartGradeView
//
//  Created by weplus on 2017/5/18.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "HQLStarView.h"

@interface HQLStarView ()

@property (strong, nonatomic) CALayer *maskColorLayer;
@property (strong, nonatomic) CAShapeLayer *maskStarShapeLayer;

@end

@implementation HQLStarView

#pragma mark - initialize

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self viewConfig];
    }
    return self;
}

#pragma mark - event 

- (void)viewConfig {
    [self maskColorLayer];
    [self maskStarShapeLayer];
    [self drawStarShape];
    [self setBackgroundColor:[UIColor redColor]];
}

- (void)calculateFrame {

}

- (void)drawStarShape {
    CGFloat radius = self.frame.size.width * 0.5;
    CGFloat centerX =radius;
    CGFloat centerY = radius;
    
//    CGFloat r0 = self.radius * sin(18 * th)/cos(36 * th); /*计算小圆半径r0 */
    CGFloat smallRadius = radius * 0.5;
    
    CGFloat x1[5]={0},y1[5]={0},x2[5]={0},y2[5]={0};
    for (int i = 0; i < 5; i ++) {
        x1[i] = centerX + radius * cos((90 + 72 * i) * (M_PI / 180));
        y1[i] = centerY - radius * sin((90 + 72 * i) * (M_PI / 180));
        x2[i] = centerX + smallRadius * cos((54 + i * 72) * (M_PI / 180));
        y2[i] = centerY - smallRadius * sin((54 + i * 72) * (M_PI / 180));
//        x1[i] = centerX + self.radius * cos((90 + i * 72) * th); /* 计算出大圆上的五个平均分布点的坐标*/
//        y1[i]=centerY - self.radius * sin((90 + i * 72) * th);
//        x2[i]=centerX + r0 * cos((54 + i * 72) * th); /* 计算出小圆上的五个平均分布点的坐标*/
//        y2[i]=centerY - r0 * sin((54 + i * 72) * th);
    }
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef startPath = CGPathCreateMutable();
    CGPathMoveToPoint(startPath, NULL, x1[0], y1[0]);
    
    
    for (int i = 1; i < 5; i ++) {
        CGPathAddLineToPoint(startPath, NULL, x2[i], y2[i]);
        CGPathAddLineToPoint(startPath, NULL, x1[i], y1[i]);
    }
    
    CGPathAddLineToPoint(startPath, NULL, x2[0], y2[0]);
    CGPathCloseSubpath(startPath);
    
    self.maskStarShapeLayer.path = startPath;
    
//    CGContextAddPath(context, startPath);
    
//    CGContextSetFillColorWithColor(context, [].CGColor);
    
//    CGContextSetStrokeColorWithColor(context, self.boundsColor.CGColor);
//    CGContextStrokePath(context);
    
//    CGRect range = CGRectMake(x1[1], 0, (x1[4] - x1[1]) * self.value , y1[2]);
    
//    CGContextAddPath(context, startPath);
//    CGContextClip(context);
//    CGContextFillRect(context, range);
    
    
    CFRelease(startPath);
}

#pragma mark - getter

- (CALayer *)maskColorLayer {
    if (!_maskColorLayer) {
        _maskColorLayer = [[CALayer alloc] init];
        [_maskColorLayer setBackgroundColor:[UIColor yellowColor].CGColor];
        [_maskColorLayer setFrame:self.bounds];
        
        [self.layer addSublayer:_maskColorLayer];
    }
    return _maskColorLayer;
}

- (CAShapeLayer *)maskStarShapeLayer {
    if (!_maskStarShapeLayer) {
        _maskStarShapeLayer = [[CAShapeLayer alloc] init];
//        [_maskStarShapeLayer setBackgroundColor:[UIColor yellowColor].CGColor];
        [_maskStarShapeLayer setFrame:self.bounds];
        
        self.layer.mask = _maskStarShapeLayer;
    }
    return _maskStarShapeLayer;
}

@end
