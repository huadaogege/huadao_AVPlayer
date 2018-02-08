//
//  SonyCamera.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/8.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "SonyCamera.h"

@implementation SonyCamera

- (NSString *)description {
    return [NSString stringWithFormat:@"相机名称:%@, 定位:%@, 售价:%@", self.name, self.info, self.price];
}

@end
