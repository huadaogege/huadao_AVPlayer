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
#import "HDRequest.h"
#import "HDAppInfoRequest.h"
#import "DesignModes.h"
#import "Arithmetics.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    HDFuncViewController *funcViewController = [[HDFuncViewController alloc] init];
//    [self initRootViewController:funcViewController];
//    [HDConfig videoPlayerSettingWithController:self];
    DesignModes *designMode = [[DesignModes alloc] init];
    [designMode designModa];
//    Arithmetics *arithmetic = [Arithmetics shareInstance];
//    NSMutableArray *sortArray = [NSMutableArray arrayWithObjects:@(8), @(6), @(0), @(9), @(7), @(4), @(2), @(1), @(3), @(5), nil];
//    [arithmetic quickSortArray:sortArray leftIndex:0 rightIndex:sortArray.count - 1];
//    NSLog(@"after sort: %@", sortArray);
//    [arithmetic bubbleSort:sortArray];
//    NSArray *source = @[@1, @2, @4, @5, @11, @13, @17, @22, @25, @38, @57];
//    NSInteger index = [arithmetic binarySearch:source target:38];
//    NSLog(@"38,index:%ld", (long)index);
    
}

- (void)initRootViewController:(HDViewController *)viewController {
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
