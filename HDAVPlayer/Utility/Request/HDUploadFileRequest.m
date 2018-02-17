//
//  HDUploadFileRequest.m
//  HDAVPlayer
//
//  Created by huadao on 2017/11/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDUploadFileRequest.h"

@implementation HDUploadFileRequest

- (HDRequestTestType)kindOfTest{
    return HDRequestTestTypeNone;
}

- (HDRequestMethod)requestMethod{
    return HDRequestMethodUploadFile;
}

- (NSString *)serviceURLSuffix{
    return @"";
}

- (NSString *)baseURLString{
    return @"http://192.168.3.145:8080/upload/FileServlet";
}

@end
