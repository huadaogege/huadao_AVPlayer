//
//  HDPlayerViewModel.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 17/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDPlayerViewModel.h"
#import <AVFoundation/AVFoundation.h>
#import "HDProgressView.h"

@interface HDPlayerViewModel() <HDProgressViewDelegate>

@property (strong, nonatomic) UIButton *pauseButton;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *stopButton;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) AVPlayer *player;
@property (assign, nonatomic) Float64 totalTime;
@property (strong, nonatomic) HDProgressView *progressView;
@property (assign, nonatomic) CGFloat progressValue;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@end

@implementation HDPlayerViewModel

/**
 初始化控件
 */
- (void)initWithControlller:(UIViewController *)controller {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_height - 40.0, Screen_width, 40.0)];
    self.bottomView.backgroundColor = [UIColor grayColor];
    [controller.view addSubview:self.bottomView];
    
    self.pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60.0, 40.0)];
    [self.pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [self.pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.pauseButton];
    
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake((Screen_width - 60.0) / 2.0, 0, 60.0, 40.0)];
    [self.playButton setTitle:@"play" forState:UIControlStateNormal];
    [self.playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.playButton];
    
    self.stopButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_width - 60.0, 0, 60.0, 40.0)];
    [self.stopButton setTitle:@"done" forState:UIControlStateNormal];
    [self.stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.stopButton];
}

- (void)pause {
    [self.player pause];
    self.displayLink.paused = YES;
}

- (void)play {
    [self.player play];
    self.displayLink.paused = NO;
}

- (void)stop {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.player pause];
        self.player = nil;
        self.displayLink.paused = YES;
        self.displayLink = nil;
        self.progressView.progressDelegate = nil;
    }];
}

@end
