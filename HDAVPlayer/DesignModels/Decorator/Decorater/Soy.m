//
//  Soy.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/6.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "Soy.h"

@implementation Soy

@synthesize name = _name;
@synthesize component = _component;

- (instancetype)initWithComponent:(id <Component>)component {
    self = [super init];
    if (self) {
        _name = @"Soy";
        _component = component;
    }
    return self;
}

- (NSString *)getName {
    return [NSString stringWithFormat:@"%@+%@", [_component getName], _name];
}

- (double)getCost {
    return 5.0 + [_component getCost];
}

@end
