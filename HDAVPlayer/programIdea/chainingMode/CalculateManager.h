//
//  CalculateManager.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/10/11.
//  Copyright © 2018 崔玉冠. All rights reserved.
//  链式编程特点:方法的返回值是block, blcok的返回值是对象本身

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculateManager : NSObject

@property (nonatomic, assign) int result;

- (CalculateManager *(^)(int))add;

- (CalculateManager *(^)(int))minus;

+ (int)makeCalculate:(void (^)(CalculateManager *make))block;

@end

NS_ASSUME_NONNULL_END
