//
//  HQLStarGradeView.h
//  HQLStarGradeView
//
//  Created by 何启亮 on 2017/5/18.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HQLStarGradeGragMinMode = 0, // 滑动时 分数增加的最低单位为0.1
    HQLStarGradeGragMidMode , // 滑动时 分数增加的最低单位为0.5
    HQLStarGradeGragMaxMode , // 滑动时 分数增加的最低单位为1
} HQLStarGradeGragMode;

@class HQLStarGradeView;

@protocol HQLStarGradeViewDelegate <NSObject>

@optional
- (void)starGradeViewDidChangeFrame:(HQLStarGradeView *)starGradeView;
- (void)starGradeView:(HQLStarGradeView *)starGradeView didChangeGrade:(CGFloat)grade;

@end

@interface HQLStarGradeView : UIView

/* 根据宽度 和 星星的个数来计算高度，默认的最大的分数为10 */
@property (assign, nonatomic) NSInteger starCount; // 星星的个数default : 5
@property (assign, nonatomic) CGFloat grade; // 评分(0 - 10)
@property (assign, nonatomic) BOOL isAllowGrade; // 是否允许评分
@property (assign, nonatomic) HQLStarGradeGragMode mode; // mode
@property (assign, nonatomic) id <HQLStarGradeViewDelegate>delegate;
@property (assign, nonatomic) BOOL isShowGrade; // 是否显示一个大的View

@end
