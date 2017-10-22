//
//  ViewController.m
//  HDAVPlayer
//
//  Created by huadao on 17/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "ViewController.h"
#import "HDFuncViewController.h"
#import "HDConfig.h"
#import "HDFmdbManager.h"
#import "HDCalculateFactory.h"
#import "HDStrategyController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HDFuncViewController *funcViewController = [[HDFuncViewController alloc] init];
    [self initRootViewController:funcViewController];
    [HDConfig videoPlayerSettingWithController:self];
    [self strategy];
}

- (void)simpleFactory {
    id<HDCalculate> cal;
    cal = [HDCalculateFactory createCalculate:@"*"];
    cal.numberA = 10;
    cal.numberB = 2;
    CGFloat result = [cal calculate];
    NSLog(@"%f", result);
}

- (void)strategy {
    HDStrategyController *vc = [[HDStrategyController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initRootViewController:(HDViewController *)viewController {
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
