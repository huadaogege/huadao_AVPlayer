//
//  HDFactoryAdd.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDFactoryAdd.h"
#import "HDCalculatesAdd.h"

@implementation HDFactoryAdd

- (id<HDCalculates>)createFactory {
    return [[HDCalculatesAdd alloc] init];
}

@end
