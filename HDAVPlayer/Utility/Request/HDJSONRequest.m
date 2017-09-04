//
//  HDJSONRequest.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDJSONRequest.h"

@implementation HDJSONRequest

- (HDRequestTestType)kindOfTest{
    return HDRequestTestTypeNone;
}

- (HDRequestMethod)requestMethod{
    return HDRequestMethodGet;
}

- (NSString *)serviceURLSuffix{
    return @"/huadao/hua/login?name=cui";
}

- (NSString *)baseURLString{
    return @"http://192.168.0.100:8080";
}
@end
