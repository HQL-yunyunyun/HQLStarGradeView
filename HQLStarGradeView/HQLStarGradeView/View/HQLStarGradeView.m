//
//  HQLStarGradeView.m
//  HQLStarGradeView
//
//  Created by 何启亮 on 2017/5/18.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "HQLStarGradeView.h"

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

#pragma mark - event

- (void)viewConfig {

}

@end
