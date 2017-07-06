//
//  HDPlayerViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/6.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface HDPlayerViewController ()

@property (strong, nonatomic) NSString *filePath;

@property (strong, nonatomic) AVPlayer *player;

@end

@implementation HDPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initControlView];
}

- (void)initControlView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_height - 40.0, Screen_width, 40.0)];
    bottomView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomView];
    
    UIButton *pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60.0, 40.0)];
    [pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:pauseButton];
    
    UIButton *stopButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_width - 60.0, 0, 60.0, 40.0)];
    [stopButton setTitle:@"done" forState:UIControlStateNormal];
    [stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:stopButton];
}

- (void)initPlayer {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    CGRect playerFrame = CGRectMake(0, 0, self.view.layer.bounds.size.height, self.view.layer.bounds.size.width);
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:self.filePath]];
    
//    Float64 duration = CMTimeGetSeconds(asset.duration);
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = playerFrame;
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    
    [self.view.layer addSublayer:playerLayer];
}

- (void)playWithFilePath:(NSString *)filePath {
    self.filePath = filePath;
    [self initPlayer];
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

- (void)stop {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.player pause];
        self.player = nil;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
