//
//  MVVMViewModel.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/31.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMModel.h"

@interface MVVMViewModel : NSObject

@property (nonatomic, strong) NSString *contentStr;

- (void)setWithModel:(MVVMModel *)model;

- (void)printClick;

@end
