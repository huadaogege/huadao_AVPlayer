//
//  HDFmdbManager.h
//  HDAVPlayer
//
//  Created by huadao on 2017/8/2.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface HDFmdbManager : NSObject

+ (HDFmdbManager *)shareInstance;

@property (nonatomic, strong) FMDatabase *db;

- (void)initDatabase;

- (void)insert;

- (void)query;

@end
