//
//  HDPlayerViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/6.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDPlayerViewController.h"
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
 初始化进度条
 */
- (void)initProgressView {
    CGRect playerFrame = [self playerPortraitFrame];
    self.progressView = [[HDProgressView alloc] initWithFrame:CGRectMake(0, playerFrame.origin.y, Screen_width, 20.0)];
    self.progressView.progressDelegate = self;
    [self.view addSubview:self.progressView];
}

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

/**
 初始化播放器
 */
- (void)initPlayer {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    CGRect playerFrame = [self playerPortraitFrame];
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:self.filePath]];
    
    Float64 duration = CMTimeGetSeconds(asset.duration);
    self.totalTime = duration;
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = playerFrame;
    self.playerLayer.videoGravity = AVLayerVideoGravityResize;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHiddenProgress)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    [self.view.layer addSublayer:self.playerLayer];
    [self.playerViewModel initWithControlller:self];
    [self initProgressView];
    [self createCADisplauLink];
}

- (void)showOrHiddenProgress {
    self.progressView.hidden = !self.progressView.hidden;
    self.bottomView.hidden = !self.bottomView.hidden;
}

- (CGRect)playerLandscapeFrame {
    CGRect frame = CGRectMake(0, 0, Screen_width, Screen_height);
    self.progressView.frame = CGRectMake(0, frame.origin.y, frame.size.width, 20.0);
    self.bottomView.frame = CGRectMake(0, frame.size.height - 40.0, frame.size.width, 40.0);
    self.playButton.frame = CGRectMake((Screen_width - 60.0) / 2.0, 0, 60.0, 40.0);
    self.stopButton.frame = CGRectMake(Screen_width - 60.0, 0, 60.0, 40.0);
    return frame;
}

- (CGRect)playerPortraitFrame {
    CGFloat height = Screen_width * (Screen_width/Screen_height*1.0);
    CGRect frame = CGRectMake(0, (Screen_height - height) / 2.0, Screen_width, height);
    self.progressView.frame = CGRectMake(0, frame.origin.y, frame.size.width, 20.0);
    self.bottomView.frame = CGRectMake(0, Screen_height - 40.0, Screen_width, 40.0);
    self.playButton.frame = CGRectMake((Screen_height - 60.0) / 2.0, 0, 60.0, 40.0);
    self.stopButton.frame = CGRectMake(Screen_height - 60.0, 0, 60.0, 40.0);
    return frame;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
