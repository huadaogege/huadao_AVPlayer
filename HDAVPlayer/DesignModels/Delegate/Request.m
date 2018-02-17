//
//  Request.m
//  HDAVPlayer
//
//  Created by huadao on 2018/1/19.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "Request.h"

@implementation Request

- (instancetype)requestWithUrlId:(NSString *)requestId {
    return [[Request alloc] initWithRequestId:requestId];
}

- (instancetype)initWithRequestId:(NSString *)requestId {
    if (self = [super init]) {
        self.requestId = requestId;
    }
    return self;
}

- (void)start {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:self.didFisishSelector]) {
            [self.delegate performSelector:self.didFisishSelector withObject:self];
        }
    });
}

@end
