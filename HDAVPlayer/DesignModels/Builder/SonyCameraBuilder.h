//
//  SonyCameraBuilder.h
//  HDAVPlayer
//
//  Created by huadao on 2018/2/8.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SonyCamera.h"

@interface SonyCameraBuilder : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *info;

- (SonyCamera *)createCamera;

@end
