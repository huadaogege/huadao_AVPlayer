//
//  Soy.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComponentProtocol.h"
#import "DecortorProcotol.h"

@interface Soy : NSObject<DecortorProcotol>

@property (nonatomic, strong) id<ComponentProtocol>component;

@end
