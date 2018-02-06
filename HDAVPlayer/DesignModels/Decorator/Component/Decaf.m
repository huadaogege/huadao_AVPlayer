//
//  Decaf.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/6.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "Decaf.h"

@implementation Decaf

@synthesize name = _name;

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"Decaf";
    }
    return self;
}

- (NSString *)getName {
    return _name;
}

- (double)getCost {
    return 28.0;
}

@end
