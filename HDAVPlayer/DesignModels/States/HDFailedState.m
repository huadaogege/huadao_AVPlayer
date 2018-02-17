//
//  HDFailedState.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/26.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDFailedState.h"

@implementation HDFailedState

- (void)updateDownOperation:(HDDown *)down {
    NSLog(@"下载失败了，要不要再来一次！");
}

@end
