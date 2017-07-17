//
//  HDModel.m
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDModel.h"

@implementation HDModel

-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err {
    if (self = [super initWithDictionary:dict error:err]) {
        [self postActionOfInit:dict error:err];
    }
    return self;
}

- (void)postActionOfInit:(NSDictionary*)dict error:(NSError**)err {
    
}

@end
