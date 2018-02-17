//
//  SonyCameraDirector.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/8.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "SonyCameraDirector.h"

@implementation SonyCameraDirector

+ (SonyCamera *)createCameraWithBuildr:(SonyCameraBuilder *)builder {
    return [builder createCamera];
}

@end
