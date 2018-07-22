//
//  HDFactoryMultiply.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDFactoryMultiply.h"
#import "HDCalculatesMultiply.h"

@implementation HDFactoryMultiply

+ (id<HDCalculates>)createFactory {
    return [[HDCalculatesMultiply alloc] init];
}

@end
