//
//  HDFileManager.m
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDFileManager.h"
#import "HDFileModel.h"

#define Except_Sql_FileName @"hd.sqlite" //数据库文件过滤掉不显示

@implementation HDFileManager

+ (HDFileManager *)shareInstance {
    static dispatch_once_t onceToken;
    static HDFileManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[HDFileManager alloc] init];
    });
    return manager;
}

- (NSFileManager *)fileManager {
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

- (NSMutableArray *)fetchLocalFilesWithDesPath:(NSString *)desFilePath {
    NSMutableArray *filesArray = [NSMutableArray arrayWithCapacity:1.0];
    NSArray *documentFiles = [self.fileManager contentsOfDirectoryAtPath:desFilePath error:nil];
    for (NSString *fileName in documentFiles) {
        if ([fileName containsString:Except_Sql_FileName]) {
            continue;
        }
        NSString *filePath = [desFilePath stringByAppendingPathComponent:fileName];
        HDFileModel *model = [[HDFileModel alloc] init];
        [model setFileName:fileName];
        [model setFilePath:filePath];
        [filesArray addObject:model];
    }
    return filesArray;
}

@end
