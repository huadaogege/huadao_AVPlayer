//
//  HDQRCodeShowViewController.m
//  HDQRCode
//
//  Created by huadao on 2017/7/14.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDQRCodeShowViewController.h"
#import "HDQRCodeManager.h"
@interface HDQRCodeShowViewController ()

@end

@implementation HDQRCodeShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qrcodeTextField.text = @"";
}

- (IBAction)createQRCode:(id)sender {
    CGFloat width = self.qrcodeImageView.frame.size.width;
    NSString *infoString = [[self randomString] stringByAppendingString:self.qrcodeTextField.text];
    UIImage *qrcodeImage = [[HDQRCodeManager shareInstance] produceQRCodeImageWith:infoString imageViewSizeWith:width];
    self.qrcodeImageView.image = qrcodeImage;
    [self.qrcodeTextField resignFirstResponder];
}

- (NSString *)randomString {
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return [string stringByAppendingString:@"$$$$$"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
