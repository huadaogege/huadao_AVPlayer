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

+ (HDFileManager *)shareInstance;


/**
 获取当前目录下所有文件

 @param desFilePath 扫描路径
 @return 当前文件夹下所有文件
 */
- (NSMutableArray *)fetchLocalFilesWithDesPath:(NSString *)desFilePath;

@end
