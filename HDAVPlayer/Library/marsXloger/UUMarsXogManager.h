//
//  UUMarsXogManager.h
//  emm_ios
//
//  Created by huadao on 2017/4/1.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUMarsXogManager : NSObject

+ (UUMarsXogManager *)shareInstance;

+ (void)initXlogerFilePath;

+ (void)appenderclose;

+ (void)whetherDeleteLogFileBySize;

+ (void)writeLogWithModule:(NSString *)moduleTag
                  function:(const char *)function
                lineNumber:(int)lineNumber
                   parameters:(NSString *)parameters;

@end
