//
//  Component.h
//  HDAVPlayer
//
//  Created by huadao on 2018/2/6.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Component <NSObject>

@property (nonatomic, strong) NSString *name;

@required

- (NSString *)getName;

- (double)getCost;

@end
