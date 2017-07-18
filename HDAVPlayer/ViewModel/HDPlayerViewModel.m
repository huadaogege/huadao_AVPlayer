//
//  HDPlayerViewModel.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 17/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDPlayerViewModel.h"

@interface HDPlayerViewModel() <HDProgressViewDelegate> {
    UIButton *_pauseButton;
    UIButton *_playButton;
    UIButton *_stopButton;
    UIView *_bottomView;
}

@end

@implementation HDPlayerViewModel

#pragma mark -- 初始化播放器及播放操作 --

/**
 初始化播放器
 */
- (void)initPlayerWithController:(UIViewController *)viewController filePath:(NSString *)filePath {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    CGRect playerFrame = [self playerPortraitFrame];
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
    
    Float64 duration = CMTimeGetSeconds(asset.duration);
    self.totalTime = duration;
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = playerFrame;
    self.playerLayer.videoGravity = AVLayerVideoGravityResize;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHiddenProgress)];
    gesture.numberOfTapsRequired = 1;
    [viewController.view addGestureRecognizer:gesture];
    [viewController.view.layer addSublayer:self.playerLayer];
    [self initWithControlller:viewController];
    [self initProgressViewWithControlller:viewController];
    [self createCADisplauLink];
}

/**
 进度条控制器回调
 
 @param value 拖动位置
 */
- (void)progressMoveToPoint:(CGFloat)value {
    CMTime moveToTime = CMTimeMakeWithSeconds(value*self.totalTime, 1.0);
    [self.player seekToTime:moveToTime completionHandler:^(BOOL finished) {
        [self.player play];
    }];
}

- (void)hd_pause {
    [self.player pause];
    self.displayLink.paused = YES;
}

- (void)hd_play {
    [self.player play];
    self.displayLink.paused = NO;
}

- (void)hd_stop {
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        [self.player pause];
        self.player = nil;
        self.displayLink.paused = YES;
        self.displayLink = nil;
        self.progressView.progressDelegate = nil;
    }];
}

#pragma mark -- 处理界面布局 --

/**
 初始化播放界面

 @param controller controller description
 */
- (void)initWithControlller:(UIViewController *)controller {
    self.viewController = controller;
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_height - 40.0, Screen_width, 40.0)];
    _bottomView.backgroundColor = [UIColor grayColor];
    [controller.view addSubview:_bottomView];
    
    _pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60.0, 40.0)];
    [_pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [_pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_pauseButton addTarget:self action:@selector(hd_pause) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_pauseButton];
    
    _playButton = [[UIButton alloc] initWithFrame:CGRectMake((Screen_width - 60.0) / 2.0, 0, 60.0, 40.0)];
    [_playButton setTitle:@"play" forState:UIControlStateNormal];
    [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(hd_play) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_playButton];
    
    _stopButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_width - 60.0, 0, 60.0, 40.0)];
    [_stopButton setTitle:@"done" forState:UIControlStateNormal];
    [_stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stopButton addTarget:self action:@selector(hd_stop) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_stopButton];
}

- (void)initProgressViewWithControlller:(UIViewController *)controller {
    CGRect playerFrame = [self playerPortraitFrame];
    self.progressView = [[HDProgressView alloc] initWithFrame:CGRectMake(0, playerFrame.origin.y, Screen_width, 20.0)];
    self.progressView.progressDelegate = self;
    [self.viewController.view addSubview:self.progressView];
}

- (void)showOrHiddenProgress {
    self.progressView.hidden = !self.progressView.hidden;
    _bottomView.hidden = !_bottomView.hidden;
}

/**
 横屏播放

 @return return value description
 */
- (CGRect)playerLandscapeFrame {
    CGRect frame = CGRectMake(0, 0, Screen_width, Screen_height);
    self.progressView.frame = CGRectMake(0, frame.origin.y, frame.size.width, 20.0);
    _bottomView.frame = CGRectMake(0, frame.size.height - 40.0, frame.size.width, 40.0);
    _playButton.frame = CGRectMake((Screen_width - 60.0) / 2.0, 0, 60.0, 40.0);
    _stopButton.frame = CGRectMake(Screen_width - 60.0, 0, 60.0, 40.0);
    return frame;
}

/**
 竖屏播放

 @return return value description
 */
- (CGRect)playerPortraitFrame {
    CGFloat height = Screen_width * (Screen_width/Screen_height*1.0);
    CGRect frame = CGRectMake(0, (Screen_height - height) / 2.0, Screen_width, height);
    self.progressView.frame = CGRectMake(0, frame.origin.y, frame.size.width, 20.0);
    _bottomView.frame = CGRectMake(0, Screen_height - 40.0, Screen_width, 40.0);
    _playButton.frame = CGRectMake((Screen_height - 60.0) / 2.0, 0, 60.0, 40.0);
    _stopButton.frame = CGRectMake(Screen_height - 60.0, 0, 60.0, 40.0);
    return frame;
}

/**
 适配播放界面

 @param notification notification description
 */
- (void)statusBarOrientationChange:(NSNotification *)notification {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeRight) {// home键靠右
        self.playerLayer.frame = [self playerLandscapeFrame];
    } else if (orientation ==UIInterfaceOrientationLandscapeLeft) {// home键靠左
        self.playerLayer.frame = [self playerLandscapeFrame];
    } else if (orientation == UIInterfaceOrientationPortrait) {
        self.playerLayer.frame = [self playerPortraitFrame];
    } if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.playerLayer.frame = [self playerPortraitFrame];
    }
}

#pragma mark -- 定时器刷新播放进度 --

/**
 创建定时器
 */
- (void)createCADisplauLink {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePlayProgress)];
    self.displayLink.paused = NO;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

/**
 更新定时器
 */
- (void)updatePlayProgress {
    CMTime currentTime = [self.player currentTime];
    CGFloat currentSeconds = currentTime.value / currentTime.timescale;
    self.progressValue = currentSeconds / self.totalTime;
    self.progressView.progressValue = self.progressValue;
}

@end
