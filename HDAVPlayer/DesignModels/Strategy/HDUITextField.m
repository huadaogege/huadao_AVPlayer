//
//  HDUITextField.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2017/10/22.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDUITextField.h"

@implementation HDUITextField

- (BOOL)validate {
    NSError *error = nil;
    BOOL validationResult = [_inputValidator validateInput:self error:&error];
    if (!validationResult) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[error localizedDescription] message:[error localizedFailureReason] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    return validationResult;
}

@end
