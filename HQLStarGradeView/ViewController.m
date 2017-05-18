//
//  ViewController.m
//  HQLStarGradeView
//
//  Created by weplus on 2017/5/18.
//  Copyright © 2017年 weplus. All rights reserved.
//

#import "ViewController.h"

#import "HQLStarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[[HQLStarView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
