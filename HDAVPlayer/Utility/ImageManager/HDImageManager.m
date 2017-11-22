//
//  HDImageManager.m
//  HDAVPlayer
//
//  Created by huadao on 2017/11/21.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDImageManager.h"
#import <UIKit/UIKit.h>
#import "HDImageModel.h"
#import <Photos/Photos.h>

#define DocumentImagePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"image"]

@implementation HDImageManager

+ (HDImageManager *)shareInstance {
    static HDImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HDImageManager alloc] init];
    });
    return manager;
}

- (NSFileManager *)fileManager {
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

- (NSArray *)prepareImagedata {
//    NSArray *fileNameArray = [self.fileManager contentsOfDirectoryAtPath:DocumentImagePath error:nil];
//    NSMutableArray *imageModels = [NSMutableArray array];
//    for (NSString *fileName in fileNameArray) {
//        NSString *imagePath = [DocumentImagePath stringByAppendingPathComponent:fileName];
//        UIImage *originImage = [UIImage imageWithContentsOfFile:imagePath];
//        UIImage *miniImage = [self thumbnailWithImage:originImage size:CGSizeMake(50, 50)];
//        HDImageModel *model = [[HDImageModel alloc] init];
//        [model setFileName:fileName];
//        [model setFilePath:imagePath];
//        [model setMiniImage:miniImage];
//        [imageModels addObject:model];
//    }
//    return imageModels;
    return [self fetchSystemPhotoLibrary];
}

/**
 制作缩略图

 @param image 原图
 @param asize 缩略图大小
 @return 缩略图
 */
- (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize {
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    } else {
        UIGraphicsBeginImageContext(asize);
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

- (NSArray *)fetchSystemPhotoLibrary {
    NSMutableArray *photos = [NSMutableArray array];
    NSMutableArray *photoCollections = [NSMutableArray array];
    //获取所有自定义相册
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        [photoCollections addObject:assetCollection];
    }
    //获取相机胶卷
    PHAssetCollection *cameraCollection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [photoCollections addObject:cameraCollection];
    for (PHAssetCollection *collection in photoCollections) {
        NSArray *array = [self enumerateAssetsInAssetCollection:collection original:NO];
        [photos addObjectsFromArray:array];
    }
    return photos;
}

- (NSArray *)enumerateAssetsInAssetCollection:(PHAssetCollection *)collection original:(BOOL)original {
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"相册名称:%@", collection.localizedTitle);
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    for (PHAsset *asset in assets) {
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            HDImageModel *model = [[HDImageModel alloc] init];
            [model setMiniImage:result];
            [model setAsset:asset];
            [array addObject:model];
        }];
    }
    return array;
}

@end
