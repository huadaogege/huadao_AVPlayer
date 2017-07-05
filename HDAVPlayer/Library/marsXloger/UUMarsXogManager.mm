//
//  UUMarsXogManager.m
//  emm_ios
//
//  Created by huadao on 2017/4/1.
//  Copyright © 2017年 uusafe. All rights reserved.
//

#import "UUMarsXogManager.h"
#import <mars/xlog/xlogger.h>
#import <mars/xlog/appender.h>
#import "LogUtil.h"

#define LOG_FILE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/xLog"]

@implementation UUMarsXogManager

+ (UUMarsXogManager *)shareInstance {
    static UUMarsXogManager *marsXlogManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!marsXlogManager) {
            marsXlogManager = [[UUMarsXogManager alloc] init];
        }
    });
    return marsXlogManager;
}

/**
 初始化log文件夹
 */
+ (void)initXlogerFilePath {
//    NSString *lastestLogPath = [UUMarsXogManager filteLastestLogFilePath];
//    [UUMarsXogManager whetherDeleteLogFileBySize];
#if DEBUG
    xlogger_SetLevel(kLevelDebug);
    appender_set_console_log(true);
#else
    xlogger_SetLevel(kLevelInfo);
    appender_set_console_log(false);
#endif
    appender_open(kAppednerAsync, [LOG_FILE_PATH UTF8String], "UULOG");
}

+ (void)appenderclose {
    appender_close();
}

+ (void)writeLogWithModule:(NSString *)moduleTag
                  function:(const char *)function
                lineNumber:(int)lineNumber
                   parameters:(NSString *)parameters {

}

/**
 获取最近(日期最小的)的一个.xlog文件
 */
+ (NSString *)filteLastestLogFilePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:LOG_FILE_PATH]) {
        return nil;
    }
    NSArray *FilePathArray = [fileManager contentsOfDirectoryAtPath:LOG_FILE_PATH error:nil];
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *sortArray = [FilePathArray sortedArrayUsingComparator:sort];
    if (sortArray.count > 0) {
        return [LOG_FILE_PATH stringByAppendingPathComponent:[sortArray lastObject]];
    }
    return nil;
}

/**
 判断log文件夹是否过大，过大直接删除，暂定最大值5M
 */
+ (void)whetherDeleteLogFileBySize {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:LOG_FILE_PATH]) {
        return;
    }
    long long fileSize = 0;
    NSArray *childFilePath = [fileManager contentsOfDirectoryAtPath:LOG_FILE_PATH error:nil];
    for (NSString *path in childFilePath) {
        NSDictionary *dic = [fileManager attributesOfItemAtPath:[LOG_FILE_PATH stringByAppendingPathComponent:path] error:nil];
        long long size = [[dic objectForKey:@"NSFileSize"] longLongValue];
        fileSize += size;
    }
    float logFileSize = fileSize/1024.0/1024.0;
    if (logFileSize > 5.0) {
        [fileManager removeItemAtPath:LOG_FILE_PATH error:nil];
    }
}

@end
