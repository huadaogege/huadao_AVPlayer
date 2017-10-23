//
//  AudiCarBuilder.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "AudiCarBuilder.h"

@implementation AudiCarBuilder

- (AudiCar *)makeBuickCar {
    AudiCar *audiCar = [[AudiCar alloc] init];
    audiCar.name = self.name;
    audiCar.level = self.level;
    audiCar.price = self.price;
    return audiCar;
}

@end
