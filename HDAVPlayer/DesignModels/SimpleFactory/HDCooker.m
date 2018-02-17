//
//  HDCooker.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "HDCooker.h"

@implementation HDCooker

@synthesize name = _name;

- (void)WorkProduce {
    NSLog(@"%@ is a cooker who cook food for people", self.name);
}

@end
