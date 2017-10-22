//
//  HDInputValidator.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2017/10/22.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDInputValidator.h"

@implementation HDInputValidator

- (BOOL)validateInput:(UITextField *)input error:(NSError *__autoreleasing *)error {
    if (error) {
        *error = nil;
    }
    return NO;
}

@end
