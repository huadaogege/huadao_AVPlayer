//
//  HDImageModel.h
//  HDAVPlayer
//
//  Created by huadao on 2017/11/21.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDModel.h"
#import <Photos/Photos.h>

@interface HDImageModel : HDModel

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong) UIImage *miniImage;

@property (nonatomic, strong) PHAsset *asset;

@end
