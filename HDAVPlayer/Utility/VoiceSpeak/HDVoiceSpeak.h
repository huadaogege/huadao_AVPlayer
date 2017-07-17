//
//  HDVoiceSpeak.h
//  HDQRCode
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDVoiceSpeak : NSObject

+ (HDVoiceSpeak*)shareInstance;

+ (void)speakVoiceFromString:(NSString *)msgString;

@end
