//
//  HDFileManager.h
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDFileManager : NSObject

@property (nonatomic, strong) NSFileManager *fileManager;

@property (nonatomic, assign) BOOL openSecrect;

+ (HDFileManager *)shareInstance;


/**
 获取当前目录下所有文件

 @param desFilePath 扫描路径
 @return 当前文件夹下所有文件
 */
- (NSMutableArray *)fetchLocalFilesWithDesPath:(NSString *)desFilePath;

/**
 获取视频文件缩略图

 @param videoPath 视频文件路径
 @return 缩略图文件
 */
+ (UIImage *)getThumbnailImage:(NSString *)videoPath;

@end
