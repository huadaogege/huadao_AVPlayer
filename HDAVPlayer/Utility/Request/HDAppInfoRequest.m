//
//  HDAppInfoRequest.m
//  HDAVPlayer
//
//  Created by huadao on 2017/10/24.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDAppInfoRequest.h"

@implementation HDAppInfoRequest

- (HDRequestTestType)kindOfTest{
    return HDRequestTestTypeNone;
}

- (HDRequestMethod)requestMethod{
    return HDRequestMethodPost;
}

- (NSString *)serviceURLSuffix{
    return [@"/lookup?id=" stringByAppendingString:self.trackId];
}

- (NSString *)baseURLString{
    return @"http://itunes.apple.com";
}


@end
