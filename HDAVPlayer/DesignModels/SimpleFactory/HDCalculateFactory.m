//
//  HDCalculateFactory.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/20.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDCalculateFactory.h"
#import "HDCalCommonTool.h"
#import "HDCalculateAdd.h"
#import "HDCalculateMinus.h"
#import "HDCalculateMultiply.h"
#import "HDCalculateDivide.h"

@implementation HDCalculateFactory

+(id<HDCalculate>)createCalculate:(NSString *)calculateTypeStr {
    NSArray *calculateChars = @[@"+", @"-", @"*", @"/"];
    Calculate_Type type = [calculateChars indexOfObject:calculateTypeStr];
    switch (type) {
        case Calculate_Type_Add:
            return [[HDCalculateAdd alloc] init];
        case Calculate_Type_Minus:
            return [[HDCalculateMinus alloc] init];
        case Calculate_Type_Multiply:
            return [[HDCalculateMultiply alloc] init];
        case Calculate_Type_Divide:
            return [[HDCalculateDivide alloc] init];
    }
}

@end
