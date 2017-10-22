//
//  HDUITextField.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2017/10/22.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDInputValidator.h"

@interface HDUITextField : UITextField

@property (nonatomic, strong) HDInputValidator *inputValidator;

- (BOOL)validate;

@end
