//
//  HDFileManager.m
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
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
        UIImage *iconImg = [HDFileManager getThumbnailImage:filePath];
        HDFileModel *model = [[HDFileModel alloc] init];
        [model setFileName:fileName];
        [model setFilePath:filePath];
        [model setIconImg:iconImg];
        [filesArray addObject:model];
    }
    return filesArray;
}

+ (UIImage *)getThumbnailImage:(NSString *)videoPath {
    if (videoPath) {
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath: videoPath] options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        // 设定缩略图的方向
        // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的
        gen.appliesPreferredTrackTransform = YES;
        // 设置图片的最大size(分辨率)
        gen.maximumSize = CGSizeMake(300, 169);
        CMTime time = CMTimeMakeWithSeconds(5.0, 600); //取第5秒，一秒钟600帧
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        if (error) {
            UIImage *placeHoldImg = [UIImage imageNamed:@"placeholder"];
            return nil;
        }
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        return thumb;
    } else {
        UIImage *placeHoldImg = [UIImage imageNamed:@"placeholder"];
        return nil;
    }
}

@end
