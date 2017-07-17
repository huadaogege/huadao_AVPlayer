//
//  UIImage+Editer.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "UIImage+Editer.h"

@implementation UIImage (Editer)

+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    if (imageWidth <= Screen_width && imageHeight <= Screen_height) {
        return image;
    }
    CGFloat max = MAX(imageWidth, imageHeight);
    CGFloat scale = max / (Screen_height*2);
    CGSize size = CGSizeMake(imageWidth / scale, imageHeight / scale);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return newImage;
}

@end
