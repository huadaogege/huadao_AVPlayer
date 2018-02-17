//
//  DarkRoast.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/6.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "DarkRoast.h"

@implementation DarkRoast

@synthesize name = _name;

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"DarkRoast";
    }
    return self;
}

- (NSString *)getName {
    return _name;
}

- (double)getCost {
    return 30.0;
}

@end
