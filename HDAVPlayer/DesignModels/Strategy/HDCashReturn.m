//
//  HDCashReturn.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "HDCashReturn.h"

@implementation HDCashReturn

@synthesize returnMoney = _returnMoney;

- (id <HDCash>)initWithReturn:(CGFloat)returnMoney {
    self = [super init];
    if (self) {
        self.returnMoney = returnMoney;
    }
    return self;
}

- (CGFloat)acceptCash:(CGFloat)cash {
    return cash - self.returnMoney;
}

@end
