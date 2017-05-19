//
//  HQLStarGradeView.m
//  HQLStarGradeView
//
//  Created by 何启亮 on 2017/5/18.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "HQLStarGradeView.h"
#import "HQLStarView.h"
#import "HMMenuView.h"

#define kMaxGrade 10
#define kMargin (self.frame.size.height * 0.1)

@interface HQLStarGradeView ()

@property (strong, nonatomic) NSMutableArray <HQLStarView *>* starViewArray;

@property (assign, nonatomic) CGFloat gradePerStar; // 每一颗星星代表的分数

@property (strong, nonatomic) UILabel *gradeLabel;
@property (strong, nonatomic) HMMenuView *menuView;

@end

@implementation HQLStarGradeView

#pragma mark - initialize method

- (instancetype)init {
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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

- (void)layoutSubviews {
    [super layoutSubviews];
    // 更新frame
    self.menuView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
    self.gradeLabel.frame = CGRectMake(kMargin, kMargin, self.frame.size.width - 2 * kMargin, self.frame.size.height - 2 * kMargin);
}

#pragma mark - event

- (void)viewConfig {
    self.starCount = 5; // 默认
    self.grade = 0; // 默认
}

- (void)calculateFrame {
    // 重新计算
    [self setStarCount:self.starCount];
}

- (void)createStarView {
    [self.starViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.starViewArray removeAllObjects];
    
    CGFloat width = self.frame.size.width / self.starCount;
    CGFloat height = width;
    
    // setframe
    CGFloat originHeight = self.frame.size.height;
    if (originHeight != width) {
        CGRect rect = self.frame;
        rect.size.height = width;
        self.frame = rect;
        
        if ([self.delegate respondsToSelector:@selector(starGradeViewDidChangeFrame:)]) {
            [self.delegate starGradeViewDidChangeFrame:self];
        }
    }
    
    
    // 开始创建
    UIView *lastView = nil;
    for (int i = 0; i < self.starCount; i++) {
        HQLStarView *starView = [[HQLStarView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lastView.frame), 0, width, height)];
        
        [self addSubview:starView];
        [self.starViewArray addObject:starView];
        lastView = starView;
    }
}

- (void)calculateGradeWithPoint:(CGPoint)point {
    // 每一分代表的长度
    if (self.isAllowGrade) {
        CGFloat lengthPerGrade = self.frame.size.width / kMaxGrade;
        CGFloat percent = (point.x / lengthPerGrade);
        
        NSInteger mulitple = 0;
        NSInteger integer = 0;
        switch (self.mode) {
            case HQLStarGradeGragMinMode: { // 每次改变都是0.1
                mulitple = 100;
                integer = 10;
                break;
            }
            case HQLStarGradeGragMidMode: { // 每次改变都是0.5
                mulitple = 10;
                integer = 5;
                break;
            }
            case HQLStarGradeGragMaxMode: { // 每次改变都是1
                mulitple = 10;
                integer = 10;
                break;
            }
        }
        
        NSInteger temp = percent * mulitple;
        NSInteger digit = temp % 10;
        if (digit != 0) {
            temp += (integer - digit);
        }
        percent = (CGFloat)temp / mulitple;
        
        if (self.isShowGrade) {
            [self.menuView setHidden:NO];
            point.y = self.menuView.frame.size.height;
            point.x = point.x <= kMargin ? kMargin : (point.x >= self.menuView.frame.size.width - kMargin ? self.menuView.frame.size.width - kMargin : point.x );
            [self.menuView drawMenuWithStartPoint:point margin:kMargin fillColor:[UIColor whiteColor] strokeColor:[UIColor blackColor] arrowDirection:HMMenuArrowDirectionUp];
            [self.gradeLabel setText:[NSString stringWithFormat:@"%g", percent]];
        }
        
        [self setGrade:percent];
        if ([self.delegate respondsToSelector:@selector(starGradeView:didChangeGrade:)]) {
            [self.delegate starGradeView:self didChangeGrade:percent];
        }
    }
}

#pragma mark - touch method

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    [self calculateGradeWithPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    [self calculateGradeWithPoint:point];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    [self calculateGradeWithPoint:point];
    if (self.isShowGrade) {
        [self.menuView setHidden:YES];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    [self calculateGradeWithPoint:point];
    if (self.isShowGrade) {
        [self.menuView setHidden:YES];
    }
}

#pragma mark - setter

- (void)setStarCount:(NSInteger)starCount {
    _starCount = starCount <= 0 ? 1 : starCount;
    self.gradePerStar = (CGFloat)kMaxGrade / _starCount;
    [self createStarView]; // 创建星星
    [self setGrade:self.grade]; // 每次重新创建星星的都是都重新赋值分数
}

- (void)setGrade:(CGFloat)grade {
    _grade = grade < 0 ? 0 : (grade > kMaxGrade ? kMaxGrade : grade);
    if (self.starViewArray.count != 0) {
        // 判断最后没有满是在哪颗星星上
        NSInteger fullStar = _grade / self.gradePerStar; // 这样可以得出哪几颗星星是满的
        BOOL isNotFull = _grade - fullStar != 0;
        NSInteger notFullStar = fullStar + ((isNotFull) ? 1 : 0);
        
        // 赋值
        int index = 1;
        for (HQLStarView *star in self.starViewArray) {
            CGFloat percent = 1;
            if (isNotFull) {
                if (index == notFullStar) {
                    percent = (_grade / self.gradePerStar) - fullStar;
                } else if (index > notFullStar) {
                    percent = 0;
                }
            } else {
                if (index > fullStar) {
                    percent = 0;
                }
            }
            if (star.lightPercent != percent) {
                [star setLightPercent:percent];
            }
            index++;
        }
        
    }
}

#pragma mark - getter

- (HMMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[HMMenuView alloc] initWithFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        [_menuView setHidden:YES];
        [_menuView addSubview:self.gradeLabel];
        
        [self addSubview:_menuView];
    }
    return _menuView;
}

- (UILabel *)gradeLabel {
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kMargin, self.frame.size.width - 2 * kMargin, self.frame.size.height - 2 * kMargin)];
        [_gradeLabel setAdjustsFontSizeToFitWidth:YES];
//        [_gradeLabel setAdjustsFontForContentSizeCategory:YES];
        [_gradeLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _gradeLabel;
}

- (NSMutableArray<HQLStarView *> *)starViewArray {
    if (!_starViewArray) {
        _starViewArray = [NSMutableArray array];
    }
    return _starViewArray;
}

@end
