//
//  HDRequest.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDRequest;
@protocol HDRequestDelegate <NSObject>

@optional
//- (void)requestDidFinished:(UURequest*)request;
//- (void) requestDidFailed:(UURequest*)request;

@end

typedef enum {
    HDRequestTestTypeNone,
    HDRequestTestTypeFailed,
    HDRequestTestTypeSucceeded,
    HDRequestTestTypeExternal,
}HDRequestTestType;

typedef enum {
    HDRequestMethodGet,
    HDRequestMethodPost,
    HDRequestMethodUploadFile,
}HDRequestMethod;

@interface HDRequest : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSMutableDictionary *parameters;
@property (nonatomic, strong) NSDictionary *httpBody;
@property (nonatomic, assign) int responseStatus;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, assign) SEL didFinishSelector;
@property (nonatomic, assign) SEL didFailSelector;
@property (nonatomic, strong) NSArray *urlRewriteParameters;
@property (nonatomic, strong) NSString *csfTokenCookie;

+ (HDRequest*)requestWithName:(NSString*)requestName;
+ (void)setBaseURLString:(NSString*)baseURLString;
- (HDRequestTestType)kindOfTest;
- (NSDictionary*)successResultForTest;
- (NSError*)errorResultForTest;
- (NSTimeInterval)timeToDelay;
- (void)start;
- (BOOL)requestSucceeded;
- (BOOL)requireSessionId;
- (BOOL)requireUserId;
- (int)resultStatus;
- (NSString*)resultErrorMessage;

- (NSString*)baseURLString;
- (NSString*)serviceURLSuffix;

- (NSString*)sessionId;

- (HDRequestMethod)requestMethod;


@end
