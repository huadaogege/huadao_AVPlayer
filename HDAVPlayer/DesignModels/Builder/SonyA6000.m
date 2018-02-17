//
//  SonyA6000.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/8.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "SonyA6000.h"

@implementation SonyA6000

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = @"Sony A6000";
        self.price = @"3799¥";
        self.info = @"中端APS-C画幅微单相机";
    }
    return self;
}

@end
