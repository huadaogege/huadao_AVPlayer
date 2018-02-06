//
//  Milk.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/6.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "Milk.h"

@implementation Milk

@synthesize name = _name;
@synthesize component = _component;

- (instancetype)initWithComponent:(id <Component>)component {
    self = [super init];
    if (self) {
        _name = @"Milk";
        _component = component;
    }
    return self;
}

- (NSString *)getName {
    return [NSString stringWithFormat:@"%@+%@", [_component getName], _name];
}

- (double)getCost {
    return 4.0 + [_component getCost];
}

@end
