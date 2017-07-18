//
//  HDPlayerViewModel.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 17/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDViewModel.h"
#import <AVFoundation/AVFoundation.h>
#import "HDProgressView.h"

@interface HDPlayerViewModel : HDViewModel

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

@property (strong, nonatomic) UIViewController *viewController;

- (void)initWithControlller:(UIViewController *)controller;

- (void)initProgressView;

- (void)initPlayerWithController:(UIViewController *)viewController;

- (void)statusBarOrientationChange:(NSNotification *)notification;

@end
