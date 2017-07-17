//
//  UIImage+Editer.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Editer)

+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;

/**
 获取视频文件缩略图
 
 @param videoPath 视频文件路径
 @return 缩略图文件
 */
+ (UIImage *)getThumbnailImage:(NSString *)videoPath;

@end
