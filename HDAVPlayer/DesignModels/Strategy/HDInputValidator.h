//
//  HDInputValidator.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2017/10/22.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
static NSString *const InputValidationErrorDomain = @"InputValidationErrorDomain";

@interface HDInputValidator : NSObject

- (BOOL)validateInput:(UITextField *)input error:(NSError *__autoreleasing *)error;

@end
