//
//  CalculateManager.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/10/11.
//  Copyright © 2018 崔玉冠. All rights reserved.
//

#import "CalculateManager.h"

@implementation CalculateManager

+ (int)makeCalculate:(void (^)(CalculateManager *make))block {
    CalculateManager *manager = [[CalculateManager alloc] init];
    block(manager);
    return manager.result;
}

- (CalculateManager *(^)(int))add {
    return ^CalculateManager *(int value) {
        _result += value;
        return self;
    };
}

- (CalculateManager *(^)(int))minus {
    return ^CalculateManager *(int value) {
        _result -= value;
        return self;
    };
}



@end
