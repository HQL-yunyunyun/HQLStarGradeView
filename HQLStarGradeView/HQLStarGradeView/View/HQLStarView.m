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

- (instancetype)init {
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self viewConfig];
}

- (void)setFrame:(CGRect)frame {
    CGFloat originWidth = self.frame.size.width;
    [super setFrame:frame];
    if (originWidth != self.frame.size.width) {
        [self calculateFrame];
    }
}

#pragma mark - event 

- (void)viewConfig {
    
    self.darkColor = [UIColor colorWithRed:(239 / 255.0) green:(239 / 255.0) blue:(239 / 255.0) alpha:1];
    self.lightColor = [UIColor yellowColor];
    
    [self maskColorLayer];
    [self maskStarShapeLayer];
    [self drawStarShape];
    
    [self setLightPercent:0];
}

- (void)calculateFrame {
    // 只要是到这个方法，就表明width已经不一样了 得重新计算
    self.maskColorLayer.frame = self.bounds;
    self.maskStarShapeLayer.frame = self.bounds;
    [self drawStarShape]; // 重新画
    [self setLightPercent:self.lightPercent];
}

- (void)drawStarShape {
    CGFloat radius = self.frame.size.width * 0.5;
    CGFloat centerX =radius;
    CGFloat centerY = radius;
    CGFloat smallRadius = radius * 0.5;
    
    // 计算每个点得坐标
    CGFloat excircleX[5];
    CGFloat excircleY[5];
    CGFloat innerCircleX[5];
    CGFloat innerCircleY[5];
    for (int i = 0; i < 5; i ++) {
        excircleX[i] = centerX + radius * cos((90 + 72 * i) * (M_PI / 180));
        excircleY[i] = centerY - radius * sin((90 + 72 * i) * (M_PI / 180));
        innerCircleX[i] = centerX + smallRadius * cos((54 + i * 72) * (M_PI / 180));
        innerCircleY[i] = centerY - smallRadius * sin((54 + i * 72) * (M_PI / 180));
    }
    // 添加路径
    CGMutablePathRef startPath = CGPathCreateMutable();
    CGPathMoveToPoint(startPath, NULL, excircleX[0], excircleY[0]);
    for (int i = 1; i < 5; i ++) {
        CGPathAddLineToPoint(startPath, NULL, innerCircleX[i], innerCircleY[i]);
        CGPathAddLineToPoint(startPath, NULL, excircleX[i], excircleY[i]);
    }
    CGPathAddLineToPoint(startPath, NULL, innerCircleX[0], innerCircleY[0]);
    CGPathCloseSubpath(startPath);
    
    self.maskStarShapeLayer.path = startPath;
    CFRelease(startPath);
}

#pragma mark - setter

- (void)setDarkColor:(UIColor *)darkColor {
    _darkColor = darkColor;
    self.backgroundColor = darkColor;
}

- (void)setLightColor:(UIColor *)lightColor {
    _lightColor = lightColor;
    self.maskColorLayer.backgroundColor = lightColor.CGColor;
}

- (void)setLightPercent:(CGFloat)lightPercent {
    _lightPercent = lightPercent < 0 ? 0 : (lightPercent > 1 ? 1 : lightPercent);
    CGRect rect = self.maskColorLayer.frame;
    rect.size.width = self.frame.size.width * _lightPercent;
    self.maskColorLayer.frame = rect;
}

#pragma mark - getter

- (CALayer *)maskColorLayer {
    if (!_maskColorLayer) {
        _maskColorLayer = [[CALayer alloc] init];
        [_maskColorLayer setBackgroundColor:self.lightColor.CGColor];
        [_maskColorLayer setFrame:self.bounds];
        
        [self.layer addSublayer:_maskColorLayer];
    }
    return _maskColorLayer;
}

- (CAShapeLayer *)maskStarShapeLayer {
    if (!_maskStarShapeLayer) {
        _maskStarShapeLayer = [[CAShapeLayer alloc] init];
        [_maskStarShapeLayer setFrame:self.bounds];
        
        self.layer.mask = _maskStarShapeLayer;
    }
    return _maskStarShapeLayer;
}

@end
