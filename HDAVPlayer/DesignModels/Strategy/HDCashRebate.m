//
//  HDCashRebate.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "HDCashRebate.h"

@implementation HDCashRebate

@synthesize rebate = _rebate;

- (id <HDCash>)initWithRebate:(CGFloat)rebate {
    self = [super init];
    if (self) {
        self.rebate = rebate;
    }
    return self;
}

- (CGFloat)acceptCash:(CGFloat)cash {
    return cash * self.rebate;
}

@end
