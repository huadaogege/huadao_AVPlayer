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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HDFuncViewController *funcViewController = [[HDFuncViewController alloc] init];
    [self initRootViewController:funcViewController];
    [HDConfig videoPlayerSettingWithController:self];
    [[HDFmdbManager shareInstance] initDatabase];
    [[HDFmdbManager shareInstance] insert];
    [[HDFmdbManager shareInstance] query];
}

- (void)initRootViewController:(HDViewController *)viewController {
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
