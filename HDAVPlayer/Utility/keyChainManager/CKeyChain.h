//
//  CKeyChain.h
//  Tools
//
//  Created by 崔玉冠 on 2018/4/5.
//  Copyright © 2018年 360CompanySafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKeyChain : NSObject

+ (CKeyChain *)shareInstance;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

@end
