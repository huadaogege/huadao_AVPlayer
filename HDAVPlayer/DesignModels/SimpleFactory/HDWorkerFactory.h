//
//  HDWorkerFactory.h
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDWorker.h"

@interface HDWorkerFactory : NSObject

+ (id <HDWorker>)workerWithProfessionName:(NSString *)professionName;


@end
