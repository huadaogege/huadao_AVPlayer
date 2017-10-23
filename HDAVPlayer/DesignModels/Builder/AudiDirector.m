//
//  AudiDirector.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "AudiDirector.h"

@implementation AudiDirector

+ (AudiCar *)creatBuickCar:(AudiCarBuilder *)builder {
    return [builder makeBuickCar];
}

@end
