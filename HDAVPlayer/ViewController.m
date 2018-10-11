//
//  ViewController.m
//  HDAVPlayer
//
//  Created by huadao on 17/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "ViewController.h"
#import "CalculateManager.h"

@interface ViewController ()

@property (nonatomic, strong)NSString *target;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    [self programIdea];
}

- (void)programIdea {
//  链式编程
    int result = [CalculateManager makeCalculate:^(CalculateManager * _Nonnull make) {
        make.add(2).add(3).add(5).minus(6);
    }];
    NSLog(@"result = %d", result);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
