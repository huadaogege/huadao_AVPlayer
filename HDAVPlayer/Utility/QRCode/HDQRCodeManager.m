//
//  HDQRCodeManager.m
//  HDQRCode
//
//  Created by huadao on 2017/7/14.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "HDQRCodeManager.h"
#import "UIImage+Editer.h"

@interface HDQRCodeManager() <AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) UIViewController *currentVC;
@end

@implementation HDQRCodeManager

+ (HDQRCodeManager *)shareInstance {
    static HDQRCodeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HDQRCodeManager alloc] init];
    });
    return manager;
}

- (UIImage *)produceQRCodeImageWith:(NSString *)infoString imageViewSizeWith:(CGFloat)width {
    CIFilter *filter = [CIFilter filterWithName:QRCodeImageIdentifier];
    [filter setDefaults];
    NSData *infoData = [infoString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    CIImage *image = [filter outputImage];
    return [HDQRCodeManager drawQRCodeImageWithCIImage:image imageViewWidth:width];
}

+ (UIImage *)drawQRCodeImageWithCIImage:(CIImage *)image imageViewWidth:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef csf = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef =  CGBitmapContextCreate(nil, width, height, 8, 0, csf, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark -- 从摄像头获取二维码 --

- (void)HD_setupSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIViewController *)currentController {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建设备输入流
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建数据输出流
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理：在主线程里刷新
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围（每一个取值0～1，以屏幕右上角为坐标原点）
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    metadataOutput.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、创建会话对象
    _session = [[AVCaptureSession alloc] init];
    // 会话采集率: AVCaptureSessionPresetHigh
    _session.sessionPreset = sessionPreset;
    
    // 6、添加设备输入流到会话对象
    [_session addInput:deviceInput];
    
    // 7、添加设备输入流到会话对象
    [_session addOutput:metadataOutput];
    
    // 8、设置数据输出类型，需要将数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    // @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
    metadataOutput.metadataObjectTypes = metadataObjectTypes;
    
    // 9、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    // 保持纵横比；填充层边界
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _videoPreviewLayer.frame = currentController.view.layer.bounds;
    [currentController.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    
    // 10、启动会话
    [_session startRunning];
}

#pragma mark - - - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    HDQRCodeManager *qrSelf = [HDQRCodeManager shareInstance];
    if (qrSelf.QRCodeDelegate && [qrSelf.QRCodeDelegate respondsToSelector:@selector(QRCodeScanManagerDidOutputMetadataObjects:)]) {
        [qrSelf.QRCodeDelegate QRCodeScanManagerDidOutputMetadataObjects:metadataObjects];
    }
}

- (void)HD_startRunning {
    [_session startRunning];
}

- (void)HD_stopRunning {
    [_session stopRunning];
    _session = nil;
}

- (void)HD_videoPreviewLayerRemoveFromSuperlayer {
    [_videoPreviewLayer removeFromSuperlayer];
}

- (void)HD_palySoundName:(NSString *)name {
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundID); // 播放音效
}
void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    
}
#pragma mark -- 从相册读取二维码 --

- (void)HD_readQRCodeFromAlbumWithCurrentController:(UIViewController *)currentController {
    self.currentVC = currentController;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    self.isPHAuthorization = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        imagePicker.delegate = self;
                        [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
                    });
                }
            }];
        } else if (status == PHAuthorizationStatusAuthorized) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *appName = [infoDict objectForKey:@"CFBundleName"];
            NSString *message = [NSString stringWithFormat:@"请前往 -> [设置 - 隐私 - 照片 - %@ 打开访问开关", appName];
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self.currentVC presentViewController:alertC animated:YES completion:nil];
        } else if (status == PHAuthorizationStatusRestricted) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"由于系统原因, 无法访问相册" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertC addAction:alertA];
            [self.currentVC presentViewController:alertC animated:YES completion:nil];
        }
    }
}

#pragma mark - - - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.currentVC dismissViewControllerAnimated:YES completion:nil];
    HDQRCodeManager *qrSelf = [HDQRCodeManager shareInstance];
    if (qrSelf.QRAlbumCodeDelegate && [qrSelf.QRAlbumCodeDelegate respondsToSelector:@selector(QRCodeAlbumManagerDidCancel)]) {
        [qrSelf.QRAlbumCodeDelegate QRCodeAlbumManagerDidCancel];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [UIImage imageSizeWithScreenImage:info[UIImagePickerControllerOriginalImage]];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count == 0) {
        [self.currentVC dismissViewControllerAnimated:YES completion:nil];
        return;
    } else {
        NSString *resultStr = @"";
        for (CIQRCodeFeature *feature in features) {
            resultStr = feature.messageString;
        }
        [self.currentVC dismissViewControllerAnimated:YES completion:nil];
        HDQRCodeManager *qrSelf = [HDQRCodeManager shareInstance];
        if (qrSelf.QRAlbumCodeDelegate && [qrSelf.QRAlbumCodeDelegate respondsToSelector:@selector(QRCodeAlbumManagerDidFinishPickingMediaWithResult:)]) {
            [qrSelf.QRAlbumCodeDelegate QRCodeAlbumManagerDidFinishPickingMediaWithResult:resultStr];
        }
    }
}




@end
