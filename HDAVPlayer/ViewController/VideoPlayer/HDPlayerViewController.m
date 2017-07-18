//
//  HDPlayerViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/6.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HDPlayerViewModel.h"

@interface HDPlayerViewController () 

@property (strong, nonatomic) HDPlayerViewModel *playerViewModel;

@end

@implementation HDPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.playerViewModel = [[HDPlayerViewModel alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

/**
 开始播放
 
 @param filePath 播放路径
 */
- (void)playWithFilePath:(NSString *)filePath {
    [self.playerViewModel initPlayerWithController:self filePath:filePath];
    [self.playerViewModel.player play];
}

- (void)statusBarOrientationChange:(NSNotification *)notification {
    [self.playerViewModel statusBarOrientationChange:notification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
