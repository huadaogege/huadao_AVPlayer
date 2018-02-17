//
//  Request.h
//  HDAVPlayer
//
//  Created by huadao on 2018/1/19.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

@property (nonatomic, assign) NSString *requestId;

@property (nonatomic, weak) id delegate;

@property (nonatomic, assign) SEL didFisishSelector;

@property (nonatomic, assign) SEL didFailedSelector;

- (instancetype)requestWithUrlId:(NSString *)requestId;

- (void)start;

@end
