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

@property (strong, nonatomic) AVPlayer *player;
@property (assign, nonatomic) Float64 totalTime;
@property (strong, nonatomic) HDProgressView *progressView;
@property (assign, nonatomic) CGFloat progressValue;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@property (strong, nonatomic) UIViewController *viewController;

- (void)initWithControlller:(UIViewController *)controller;

- (void)initPlayerWithController:(UIViewController *)viewController filePath:(NSString *)filePath;

- (void)statusBarOrientationChange:(NSNotification *)notification;

@end
