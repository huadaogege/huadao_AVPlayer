//
//  SonyCameraBuilder.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/8.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "SonyCameraBuilder.h"

@implementation SonyCameraBuilder

- (SonyCamera *)createCamera {
    SonyCamera *camera = [[SonyCamera alloc] init];
    camera.name = self.name;
    camera.price = self.price;
    camera.info = self.info;
    return camera;
}

@end
