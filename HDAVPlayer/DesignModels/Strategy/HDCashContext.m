//
//  HDCashContext.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "HDCashContext.h"
#import "HDCashNormal.h"
#import "HDCashReturn.h"
#import "HDCashRebate.h"

@implementation HDCashContext


- (instancetype)initWithCashType:(CashType)type {
    self = [super init];
    if (self) {
        if (type == CashNormal) {
            self.hdcash = [[HDCashNormal alloc] init];
        } else if (type == CashReturn) {
            self.hdcash = [[HDCashReturn alloc] initWithReturn:5.0];
        } else if (type == CashRebate){
            self.hdcash = [[HDCashRebate alloc] initWithRebate:0.8];
        }
    }
    return self;
}

- (CGFloat)getCashResult:(CGFloat)cash {
    return [self.hdcash acceptCash:cash];
}

@end
