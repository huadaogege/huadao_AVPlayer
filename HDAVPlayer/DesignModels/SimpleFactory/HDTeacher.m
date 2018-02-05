//
//  HDTeacher.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "HDTeacher.h"

@implementation HDTeacher

@synthesize name = _name;

- (void)WorkProduce {
    NSLog(@"%@ is a teacher who teach knowledge to the student", self.name);
}

@end
