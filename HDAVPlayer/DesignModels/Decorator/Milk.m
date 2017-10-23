//
//  Milk.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "Milk.h"

@implementation Milk {
    NSString *_name;
}

- (instancetype)initWithComponent:(id<ComponentProtocol>)component {
    if (self = [super init]) {
        _name = @"Milk";
        self.component = component;
    }
    return self;
}

- (NSString *)getName {
    return [NSString stringWithFormat:@"%@ + %@", [self.component getName] ,_name];
}

- (double)cost {
    return 0.30 + [self.component cost];
}

@end
