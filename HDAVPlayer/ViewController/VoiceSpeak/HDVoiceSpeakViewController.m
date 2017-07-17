//
//  VoiceSpeakViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDVoiceSpeakViewController.h"
#import "HDVoiceSpeak.h"

@interface HDVoiceSpeakViewController ()

@end

@implementation HDVoiceSpeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)playButton:(id)sender {
    NSString *string = self.inputTextView.text;
    [HDVoiceSpeak speakVoiceFromString:string];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
