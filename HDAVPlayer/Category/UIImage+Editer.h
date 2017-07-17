//
//  UIImage+Editer.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Editer)


/**
 修改图片大小,获取一张小于屏幕的图片

 @param image 原图
 @return 修剪之后的图
 */
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;

/**
 获取视频文件缩略图
 
 @param videoPath 视频文件路径
 @return 缩略图文件
 */
+ (UIImage *)getThumbnailImage:(NSString *)videoPath;

@end
