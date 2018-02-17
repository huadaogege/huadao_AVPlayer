//
//  HDNurse.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "HDNurse.h"

@implementation HDNurse

@synthesize name = _name;

- (void)WorkProduce {
    NSLog(@"%@ is a Nurse who take care of the sicker", self.name);
}


@end
