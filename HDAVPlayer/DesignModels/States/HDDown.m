//
//  HDDown.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/26.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDDown.h"
#import "HDDownState.h"

@implementation HDDown

- (instancetype)init {
    if (self = [super init]) {
        self.state = [[HDDownState alloc] init];
    }
    return self;
}

- (void)updateDownOperation {
    [self.state updateDownOperation:self];
}

@end
