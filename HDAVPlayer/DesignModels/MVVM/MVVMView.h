//
//  MVVMView.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/31.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMViewModel.h"

@interface MVVMView : UIView


- (void)setWithViewModel:(MVVMViewModel *)viewModel;

@end
