//
//  ViewController.m
//  HQLStarGradeView
//
//  Created by weplus on 2017/5/18.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "ViewController.h"

#import "HQLStarGradeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HQLStarGradeView *starGradeView = [[HQLStarGradeView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
    starGradeView.isAllowGrade = YES;
    starGradeView.isShowGrade = YES;
    [self.view addSubview:starGradeView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
