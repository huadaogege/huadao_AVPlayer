//
//  HDDownLoadState.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/26.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HDDown;
@protocol HDDownLoadState <NSObject>

- (void)updateDownOperation:(HDDown *)down;

@end
