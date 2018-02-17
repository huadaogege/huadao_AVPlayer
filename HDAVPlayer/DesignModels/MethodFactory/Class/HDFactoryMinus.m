//
//  HDFactoryMinus.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDFactoryMinus.h"
#import "HDCalculatesMinus.h"

@implementation HDFactoryMinus

- (id<HDCalculates>)createFactory {
    return [[HDCalculatesMinus alloc] init];
}

@end
