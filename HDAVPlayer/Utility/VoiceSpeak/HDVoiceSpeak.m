//
//  HDVoiceSpeak.m
//  HDQRCode
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDVoiceSpeak.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@implementation HDVoiceSpeak

+ (HDVoiceSpeak *)shareInstance {
    static HDVoiceSpeak *speakManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        speakManager = [[HDVoiceSpeak alloc] init];
    });
    return speakManager;
}

+ (void)speakVoiceFromString:(NSString *)msgString {
    if( [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:msgString];
        utterance.rate *= 1.0;
        AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
        NSString *preferredLang = @"zh-CN";
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[NSString stringWithFormat:@"%@",preferredLang]];
        utterance.voice = voice;
        [synth speakUtterance:utterance];
    }
}

@end
