//
//  HDWorkerFactory.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "HDWorkerFactory.h"
#import "HDFactoryTool.h"
#import "HDNurse.h"
#import "HDTeacher.h"
#import "HDCooker.h"
#import "HDCoder.h"

@implementation HDWorkerFactory

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id <HDWorker>)workerWithProfessionName:(NSString *)professionName {
    NSArray *professions = @[@"Nurse", @"Teacher", @"Cooker", @"Coder"];
    ProfessionName profession = [professions indexOfObject:professionName];
    id <HDWorker> worker;
    switch (profession) {
        case Nurse:
            worker = [[HDNurse alloc] init];
            break;
        case Teacher:
            worker = [[HDTeacher alloc] init];
            break;
        case Cooker:
            worker = [[HDCooker alloc] init];
            break;
        case Coder:
            worker = [[HDCoder alloc] init];
            break;
        default:
            worker = nil;
            break;
    }
    return worker;
}


@end
