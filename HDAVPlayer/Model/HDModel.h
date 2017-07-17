//
//  HDModel.h
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface HDModel : JSONModel

- (void)postActionOfInit:(NSDictionary*)dict error:(NSError**)err;

@end
