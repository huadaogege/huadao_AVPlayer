//
//  ComponentProtocol.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ComponentProtocol <NSObject>

@optional

- (NSString *)getName;

//价格
- (double)cost;

@end
