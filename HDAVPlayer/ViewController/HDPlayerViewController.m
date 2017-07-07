//
//  HDPlayerViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/6.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HDProgressView.h"
@interface HDPlayerViewController () <HDProgressViewDelegate>

@property (strong, nonatomic) NSString *filePath;

@property (strong, nonatomic) AVPlayer *player;

@property (assign, nonatomic) Float64 totalTime;

@property (strong, nonatomic) HDProgressView *progressView;

@property (assign, nonatomic) CGFloat progressValue;

@property (strong, nonatomic) CADisplayLink *displayLink;

@end

@implementation HDPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initControlView];
    [self initProgressView];
}

/**
 初始化控件
 */
- (void)initControlView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_height - 40.0, Screen_width, 40.0)];
    bottomView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomView];
    
    UIButton *pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60.0, 40.0)];
    [pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:pauseButton];
    
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake((Screen_width - 60.0) / 2.0, 0, 60.0, 40.0)];
    [playButton setTitle:@"play" forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:playButton];
    
    UIButton *stopButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_width - 60.0, 0, 60.0, 40.0)];
    [stopButton setTitle:@"done" forState:UIControlStateNormal];
    [stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:stopButton];
}

/**
 初始化播放器
 */
- (void)initPlayer {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    CGRect playerFrame = CGRectMake(0, 0, self.view.layer.bounds.size.height, self.view.layer.bounds.size.width);
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:self.filePath]];
    
    Float64 duration = CMTimeGetSeconds(asset.duration);
    self.totalTime = duration;
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = playerFrame;
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    [self.view.layer addSublayer:playerLayer];
    [self createCADisplauLink];
}

/**
 初始化进度条
 */
- (void)initProgressView {
    self.progressView = [[HDProgressView alloc] initWithFrame:CGRectMake(20.0, Screen_height - 100.0, Screen_width - 40.0, 20.0)];
    self.progressView.progressDelegate = self;
    [self.view addSubview:self.progressView];
}

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

/**
 开始播放

 @param filePath 播放路径
 */
- (void)playWithFilePath:(NSString *)filePath {
    self.filePath = filePath;
    [self initPlayer];
    [self.player play];
}

/**
 拖动进度条之后设置播放开始进度

 @param newPosition 新的播放点
 */
- (void)setAnyPositionToPlay:(Float64)newPosition {
    CMTime moveToTime = CMTimeMakeWithSeconds(newPosition*self.totalTime, 1.0);
    [self.player seekToTime:moveToTime completionHandler:^(BOOL finished) {
        [self.player play];
    }];
}

/**
 进度条控制器回调

 @param value 拖动位置
 */
- (void)progressMoveToPoint:(CGFloat)value {
    [self setAnyPositionToPlay:value];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
