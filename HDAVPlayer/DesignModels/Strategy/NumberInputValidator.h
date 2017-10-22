//
//  NumberInputValidator.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2017/10/22.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDInputValidator.h"
#import <UIKit/UIKit.h>
@interface NumberInputValidator : HDInputValidator

- (BOOL)validateInput:(UITextField *)input error:(NSError *__autoreleasing *)error;

@end
