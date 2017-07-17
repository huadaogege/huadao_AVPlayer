//
//  HDQRCodeScanViewController.m
//  HDQRCode
//
//  Created by 崔玉冠 on 17/7/16.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDQRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HDQRCodeManager.h"
@interface HDQRCodeScanViewController ()<HDQRCodeManagerDelegate, HDQRCodeAlbumManagerDelegate>

@end

@implementation HDQRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startScanQRCode];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"扫一扫";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
}

- (void)rightBarButtonItenAction {
    [[HDQRCodeManager shareInstance] HD_readQRCodeFromAlbumWithCurrentController:self];
    [HDQRCodeManager shareInstance].QRAlbumCodeDelegate = self;
}

- (void)startScanQRCode {
    self.outputTextView.hidden = YES;
    NSArray *array = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    [[HDQRCodeManager shareInstance] HD_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:array currentController:self];
    [HDQRCodeManager shareInstance].QRCodeDelegate = self;
}

- (void)QRCodeScanManagerDidOutputMetadataObjects:(NSArray *)metadataObjects {
    HDQRCodeManager *scanManager = [HDQRCodeManager shareInstance];
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager HD_palySoundName:@"HDQRCode.bundle/sound.caf"];
        [scanManager HD_stopRunning];
        [scanManager HD_videoPreviewLayerRemoveFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSString *string = [obj stringValue];
        self.outputTextView.hidden = NO;
        self.outputTextView.text = string;
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}

- (void)QRCodeAlbumManagerDidCancel {
    NSLog(@"取消选择相册");
}

- (void)QRCodeAlbumManagerDidFinishPickingMediaWithResult:(NSString *)result {
    self.outputTextView.text = result;
    self.outputTextView.hidden = NO;
    HDQRCodeManager *scanManager = [HDQRCodeManager shareInstance];
    [scanManager HD_palySoundName:@"HDQRCode.bundle/sound.caf"];
    [scanManager HD_stopRunning];
    [scanManager HD_videoPreviewLayerRemoveFromSuperlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
