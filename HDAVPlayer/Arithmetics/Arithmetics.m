//
//  Arithmetics.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/4.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "Arithmetics.h"

@implementation Arithmetics

static id instance;

+ (Arithmetics *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Arithmetics alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)copy {
    return instance;
}

- (void)quickSortArray:(NSMutableArray*)array
             leftIndex:(NSInteger)leftIndex
            rightIndex:(NSInteger)rightIndex {
    //如果数组长度为0或1时候直接返回
    if (leftIndex >= rightIndex) {
        return;
    }
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    NSInteger key = [array[i] integerValue];
    while (i < j) {
        //首先从右边j开始查找比基准数小的值
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小,则将查找到的数放到i的位置
        [array replaceObjectAtIndex:i withObject:array[j]];
        
        //当右边查找到一个比基准数小的值时,就从i开始继续找比基准数大的值
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续找
            i++;
        }
        //如果比基准数大,则将查找到的大值调换到j的位置
        [array replaceObjectAtIndex:j withObject:array[i]];
    }
    //将基准数放在正确的位置
    [array replaceObjectAtIndex:i withObject:@(key)];
    /*递归排序*/
    //排序基准数左边的数
    [self quickSortArray:array leftIndex:leftIndex rightIndex:i-1];
    //排序基准数右边的数
    [self quickSortArray:array leftIndex:i+1 rightIndex:rightIndex];
}

- (void)bubbleSort:(NSMutableArray*)array {
    for (int i = 0; i < array.count; i ++) {
        for (int j = 0; j < array.count-i-1; j ++) {
            NSInteger left = [array[j] integerValue];
            NSInteger right = [array[j+1] integerValue];
            if (left < right) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"%@", array);
}

- (NSInteger)binarySearch:(NSArray *)source target:(NSInteger)target {
    if (source.count == 0) {
        return -1;
    }
    NSInteger low = 0;
    NSInteger high = source.count - 1;
    while (low <= high) {
        NSInteger mid = low + ((high-low)>>1);
        NSInteger num = [[source objectAtIndex:mid] integerValue];
        if (target == num) {
            return low;
        } else if (target > num) {
            low = mid+1;
        } else {
            high =mid-1;
        }
    }
    return -1;
}

@end
