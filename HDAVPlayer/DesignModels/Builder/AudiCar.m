//
//  AudiCar.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "AudiCar.h"

@implementation AudiCar

- (NSString *)description {
    return [NSString stringWithFormat:@"我是一辆:%@ %@车 价格:%@",self.name,self.level,self.price];
}

@end
