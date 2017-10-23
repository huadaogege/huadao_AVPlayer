//
//  Decaf.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "Decaf.h"

@implementation Decaf{
    NSString *_name;
}

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

- (double)cost {
    return 4.0;
}

@end
