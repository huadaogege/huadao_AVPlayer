//
//  HDQRCodeShowViewController.m
//  HDQRCode
//
//  Created by huadao on 2017/7/14.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDQRCodeShowViewController.h"
#import "HDQRCodeManager.h"
#import "NSString+Editer.h"
@interface HDQRCodeShowViewController ()

@end

@implementation HDQRCodeShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qrcodeTextField.text = @"";
}

- (IBAction)createQRCode:(id)sender {
    CGFloat width = self.qrcodeImageView.frame.size.width;
    NSString *infoString = [[NSString randomStringLength:16 spackMark:@"$$$$$"] stringByAppendingString:self.qrcodeTextField.text];
    UIImage *qrcodeImage = [[HDQRCodeManager shareInstance] produceQRCodeImageWith:infoString imageViewSizeWith:width];
    self.qrcodeImageView.image = qrcodeImage;
    [self.qrcodeTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
