//
//  HDCalculateFactory.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/20.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDCalculate.h"
@class HDCalCommonTool;

@interface HDCalculateFactory : NSObject

+(id<HDCalculate>)createCalculate:(NSString *)calculateType;

@end
