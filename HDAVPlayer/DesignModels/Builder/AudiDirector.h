//
//  AudiDirector.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//  Audi汽车销售

#import <Foundation/Foundation.h>
#import "AudiCar.h"
#import "AudiCarBuilder.h"

@interface AudiDirector : NSObject

+ (AudiCar *)creatBuickCar:(AudiCarBuilder *)builder;

@end
