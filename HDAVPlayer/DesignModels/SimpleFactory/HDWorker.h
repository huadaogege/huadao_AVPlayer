//
//  HDWorker.h
//  HDAVPlayer
//
//  Created by huadao on 2018/2/5.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HDWorker <NSObject>

@property (nonatomic, strong) NSString *name;

- (void)WorkProduce;

@end
