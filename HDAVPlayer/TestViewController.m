//
//  TestViewController.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/4/7.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 91, 91)];
    view.backgroundColor = [UIColor redColor];
    [self.baseView addSubview:view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
