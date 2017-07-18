//
//  UIAlertController+Editer.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/18.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "UIAlertController+Editer.h"

@implementation UIAlertController (Editer)

+ (UIAlertController *)alertViewControllerWithTile:(NSString *)title
                                           message:(NSString *)message
                                         leftTitle:(NSString *)leftTitle
                                        rightTitle:(NSString *)rightTitle
                                            hander:(void(^)(clickIndex index))hander {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (leftTitle) {
        UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            hander(leftIndex);
        }];
        [alertController addAction:leftAction];
    }
    if (rightTitle) {
        UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            hander(rightIndex);
        }];
        [alertController addAction:rightAction];
    }
    return alertController;
}

@end
