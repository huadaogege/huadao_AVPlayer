//
//  HDImageManager.h
//  HDAVPlayer
//
//  Created by huadao on 2017/11/21.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDImageManager : NSObject

+ (HDImageManager *)shareInstance;

@property (nonatomic, strong) NSFileManager *fileManager;

- (NSArray *)prepareImagedata;

@end
