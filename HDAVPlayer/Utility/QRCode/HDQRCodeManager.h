//
//  HDQRCodeManager.h
//  HDQRCode
//
//  Created by huadao on 2017/7/14.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HDQRCodeManagerDelegate <NSObject>

- (void)QRCodeScanManagerDidOutputMetadataObjects:(NSArray *)metadataObjects;

@end

@protocol HDQRCodeAlbumManagerDelegate <NSObject>

- (void)QRCodeAlbumManagerDidCancel;

- (void)QRCodeAlbumManagerDidFinishPickingMediaWithResult:(NSString *)result;

@end

@interface HDQRCodeManager : NSObject

@property (nonatomic, weak)id <HDQRCodeManagerDelegate>QRCodeDelegate;

@property (nonatomic, weak)id <HDQRCodeAlbumManagerDelegate>QRAlbumCodeDelegate;

@property (nonatomic, assign) BOOL isPHAuthorization;

+ (HDQRCodeManager *)shareInstance;

- (UIImage *)produceQRCodeImageWith:(NSString *)infoString imageViewSizeWith:(CGFloat)width;

- (void)HD_setupSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIViewController *)currentController;

- (void)HD_readQRCodeFromAlbumWithCurrentController:(UIViewController *)currentController;

/// 开启会话对象扫描
- (void)HD_startRunning;
/// 停止会话对象扫描
- (void)HD_stopRunning;
/// 移除 videoPreviewLayer 对象
- (void)HD_videoPreviewLayerRemoveFromSuperlayer;
/// 播放音效文件
- (void)HD_palySoundName:(NSString *)name;

@end
