//
//  AudiCarBuilder.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//  Audi建造者

#import <Foundation/Foundation.h>
#import "AudiCar.h"

@interface AudiCarBuilder : NSObject

@property (nonatomic, copy)NSString *name;// 名字
@property (nonatomic, copy)NSString *level;// 级别
@property (nonatomic, copy)NSString *price;// 价格

- (AudiCar *)makeBuickCar;

@end
