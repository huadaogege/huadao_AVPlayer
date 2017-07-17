//
//  ViewController.m
//  HDAVPlayer
//
//  Created by huadao on 17/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "ViewController.h"
//#import "HDFileListViewController.h"
#import "HDFuncViewController.h"
#import "HDFileManager.h"
@interface ViewController ()

//@property (nonatomic, strong) HDFileListViewController *fileListViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能列表";
//    self.fileListViewController = [[HDFileListViewController alloc] init];
//    [self initRootViewController:self.fileListViewController];
//    [self initControlBarItem];
    HDFuncViewController *funcViewController = [[HDFuncViewController alloc] init];
    [self initRootViewController:funcViewController];
}

- (void)initControlBarItem {
    UITapGestureRecognizer *openGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openSecrect)];
    openGesture.numberOfTapsRequired = 5;
    UIView *leftlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftlView addGestureRecognizer:openGesture];
    
    UITapGestureRecognizer *closeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSecrect)];
    closeGesture.numberOfTapsRequired = 4;
    UIView *rightlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightlView addGestureRecognizer:closeGesture];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftlView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightlView];
}

- (void)openSecrect {
    [HDFileManager shareInstance].openSecrect = YES;
}

- (void)closeSecrect {
    [HDFileManager shareInstance].openSecrect = NO;
}

- (void)initRootViewController:(HDViewController *)viewController {
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
