//
//  HDDown.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/26.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDDownLoadState.h"

@interface HDDown : NSObject

@property (nonatomic,strong) id<HDDownLoadState>state;

- (void)updateDownOperation;

@end
