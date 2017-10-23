//
//  DarkRoast.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "DarkRoast.h"

@implementation DarkRoast{
    NSString *_name;
}

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

- (double)cost {
    return 3.0;
}

@end
