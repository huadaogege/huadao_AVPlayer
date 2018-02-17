//
//  SonyA5100.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/8.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "SonyA5100.h"

@implementation SonyA5100

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = @"Sony A5100";
        self.price = @"2100¥";
        self.info = @"入门APS-C画幅微单相机";
    }
    return self;
}

@end
