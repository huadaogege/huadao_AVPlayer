//
//  Arithmetics.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/4.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Arithmetics : NSObject

+ (Arithmetics *)shareInstance;

/**
 快速排序
 */
- (void)quickSortArray:(NSMutableArray*)array
             leftIndex:(NSInteger)leftIndex
            rightIndex:(NSInteger)rightIndex;

/**
 冒泡排序
 */
- (void)bubbleSort:(NSMutableArray*)array;

/**
 二分查找
 */
- (NSInteger)binarySearch:(NSArray *)source
                   target:(NSInteger)target;

@end
