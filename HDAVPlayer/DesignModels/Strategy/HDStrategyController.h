//
//  HDStrategyController.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2017/10/22.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDUITextField.h"

@interface HDStrategyController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet HDUITextField *numberTF;
@property (weak, nonatomic) IBOutlet HDUITextField *alphaTF;

@end
