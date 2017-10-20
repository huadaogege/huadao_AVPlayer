//
//  HDCalculate.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/20.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HDCalculate <NSObject>

@property(nonatomic, assign) CGFloat numberA;

@property(nonatomic, assign) CGFloat numberB;

- (CGFloat)calculate;

@end
