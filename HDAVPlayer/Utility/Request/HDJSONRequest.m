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
    return HDRequestMethodPost;
}

- (NSString *)serviceURLSuffix{
    return @"/ios/test/test.json";
}

- (NSString *)baseURLString{
    return @"http://192.168.3.195";
}
@end
