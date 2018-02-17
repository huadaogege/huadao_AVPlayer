//
//  HDCashContext.h
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDCash.h"

typedef NS_ENUM(NSInteger, CashType) {
    CashNormal = 0,
    CashReturn,
    CashRebate
};

@interface HDCashContext : NSObject

@property (nonatomic, strong) id <HDCash> hdcash;


- (instancetype)initWithCashType:(CashType)type;

- (CGFloat)getCashResult:(CGFloat)cash;

@end
