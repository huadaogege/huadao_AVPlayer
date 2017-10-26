//
//  AudiCar.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//  Audi基类

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, FamousCarBrandOptions) {
    FamousCarBrandBenz = 0,
    FamousCarBrandBMW = 1 << 0,
    FamousCarBrandAudi = 1 << 1,
    FamousCarBrandPorsche = 1 << 2,
    FamousCarBrandFerrari = 1 << 3,
    FamousCarBrandJaguar = 1 << 4,
    FamousCarBrandLandrover = 1 << 5
};

@interface AudiCar : NSObject

@property (nonatomic, copy)NSString *name;// 名字
@property (nonatomic, copy)NSString *level;// 级别
@property (nonatomic, copy)NSString *price;// 价格

- (NSString *)description;

@end
