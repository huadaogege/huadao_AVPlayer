//
//  SonyCameraDirector.h
//  HDAVPlayer
//
//  Created by huadao on 2018/2/8.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SonyCameraBuilder.h"
#import "SonyCamera.h"

@interface SonyCameraDirector : NSObject

+ (SonyCamera *)createCameraWithBuildr:(SonyCameraBuilder *)builder;

@end