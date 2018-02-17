//
//  Decorater.h
//  HDAVPlayer
//
//  Created by huadao on 2018/2/6.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@protocol Decorater <Component>

@required

@property (nonatomic, strong) id <Component> component;//装饰者需要持有被装饰者

- (instancetype)initWithComponent:(id <Component>)component;

@end
