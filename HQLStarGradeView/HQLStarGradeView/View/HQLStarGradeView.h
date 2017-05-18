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

@interface HQLStarGradeView : UIView

/* 根据宽度 和 星星的个数来计算高度，默认的最大的分数为10(可以自定义) */
@property (assign, nonatomic) NSInteger starCount; // 星星的个数
@property (assign, nonatomic) CGFloat grade; // 评分(0 - 10)
@property (assign, nonatomic) BOOL isAllowGrade; // 是否允许评分
@property (assign, nonatomic) HQLStarGradeGragMode mode; // mode

@end
