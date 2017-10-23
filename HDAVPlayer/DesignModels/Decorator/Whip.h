//
//  Whip.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DecortorProcotol.h"
#import "ComponentProtocol.h"

@interface Whip : NSObject<DecortorProcotol>

@property (nonatomic, strong) id<ComponentProtocol> component;

@end
