//
//  Espresso.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/6.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "Espresso.h"

@implementation Espresso

@synthesize name = _name;

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"Espresso";
    }
    return self;
}

- (NSString *)getName {
    return _name;
}

- (double)getCost {
    return 25.0;
}

@end
