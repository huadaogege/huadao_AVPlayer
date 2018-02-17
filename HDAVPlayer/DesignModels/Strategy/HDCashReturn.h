//
//  HDCashReturn.h
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDCash.h"

@interface HDCashReturn : NSObject<HDCash>

@property (nonatomic, assign)CGFloat returnMoney;

- (id <HDCash>)initWithReturn:(CGFloat)returnMoney;

@end
