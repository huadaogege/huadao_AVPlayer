//
//  HDRequest.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDRequest.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

#define SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code) { _Pragma("clang diagnostic push")  _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")  code;  _Pragma("clang diagnostic pop")}
//SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING( return [_target performSelector:_action withObject:self] );


@interface CTimeOutRequest : AFJSONRequestSerializer

@end

@implementation CTimeOutRequest

- (id)init {
    if (self = [super init]) {
        self.timeoutInterval = 35;
        //        [self setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content"];
    }
    return self;
}
@end

static NSDictionary *__requestList = nil;
static NSString *__base_url;

@interface HDRequest ()

@property (nonatomic, retain) NSString *className;

@end


@implementation HDRequest

+ (HDRequest*)requestWithName:(NSString*)requestName
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *requestListPath = [[NSBundle mainBundle] pathForResource:@"RequestList" ofType:@"plist"];
        __requestList = [NSDictionary dictionaryWithContentsOfFile:requestListPath];
        NSAssert(__requestList, @"please supply correct request list file");
    });
    NSString *requestClassName = [__requestList objectForKey:requestName];
    NSAssert(requestClassName, @"request for %@ is not set", requestName);
    HDRequest *request = [[NSClassFromString(requestClassName) alloc] init];
    request.className = requestClassName;
    return request;
}

+ (void)setBaseURLString:(NSString*)baseURLString {
    __base_url = baseURLString;
}

- (HDRequestTestType)kindOfTest {
    return HDRequestTestTypeNone;
}
- (NSDictionary*)successResultForTest {
    return nil;
}
- (NSError*)errorResultForTest {
    return nil;
}

- (NSTimeInterval)timeToDelay {
    return 2;
}

- (NSString*)baseURLString {
    return __base_url;
    return @"http://192.168.3.195";
}

- (NSString*)serviceURLSuffix {
    return @"/";
}

- (NSString*)sessionId {
    return nil;
    return @"123123123";
}

- (BOOL)requireSessionId {
    return YES;
}
- (BOOL)requireUserId {
    return YES;
}

- (HDRequestMethod)requestMethod {
    return HDRequestMethodGet;
}

- (AFHTTPResponseSerializer*)serializer {
    return [AFJSONResponseSerializer serializer];
}

- (void)notifyDelegate {
    if (self.delegate && [self.delegate respondsToSelector:self.didFinishSelector]) {
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.delegate performSelector:self.didFinishSelector withObject:self]);
    }
}

- (AFHTTPRequestSerializer*)requestSerializer {
    return [CTimeOutRequest serializer];
}

- (void)start {
    if ([self kindOfTest] != HDRequestTestTypeNone && [self kindOfTest] != HDRequestTestTypeExternal) {
        [self test];
        return;
    }
    NSString *URLString = [NSString stringWithFormat:@"%@%@", [self baseURLString], [self serviceURLSuffix]];
    if (self.urlRewriteParameters && self.urlRewriteParameters.count) {
        NSString *suffix = [self.urlRewriteParameters componentsJoinedByString:@"/"];
        URLString = [URLString stringByAppendingFormat:@"/%@/", suffix];
    }
    if ([self kindOfTest] == HDRequestTestTypeExternal) {
        URLString = @"http://httpbin.org/post";
    }
    NSLog(@"%s----URLString:%@", __func__, URLString);
    if (!self.parameters) {
        self.parameters = [NSMutableDictionary dictionary];
    }
    if (![self.parameters isKindOfClass:[NSMutableDictionary class]]) {
        self.parameters = [NSMutableDictionary dictionaryWithDictionary:self.parameters];
    }
    if (self.parameters) {
        NSArray *keys = [self.parameters allKeys];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:keys.count];
        for (int i = 0; i < keys.count; i++) {
            NSString *key = [keys objectAtIndex:i];
            NSString *value = [self.parameters objectForKey:key];
            NSString *parameter = [NSString stringWithFormat:@"%@=%@", key, value];
            [array addObject:parameter];
        }
        
        NSString *parameters = [array componentsJoinedByString:@"&"];
        parameters = [parameters stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (parameters.length) {
            URLString = [NSString stringWithFormat:@"%@?%@", URLString, parameters];
        }
    }
    NSLog(@"%s----self.parameters:%@", __func__, self.parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *request = [self requestSerializer];
    manager.requestSerializer = request;
    manager.responseSerializer = [self serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes  setByAddingObjectsFromArray:@[@"text/html", @"text/plain"]];
    
    AFSecurityPolicy *securityPolicy = nil;
    
    securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;

    manager.securityPolicy = securityPolicy;
    NSLog(@"%s----self.parameters:%@", __func__, manager);
    
    if ([self requestMethod] == HDRequestMethodGet) {
        [manager GET:URLString parameters:self.httpBody progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
            [self handleSuccess:operation response:responseObject];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [self handleFail:operation error:error];
        }];
    }else if ([self requestMethod] == HDRequestMethodPost) {
        if (!self.httpBody) {
            self.httpBody = @{};
        }
        //NSLog(@"%s----URLString:%@ ----self.httpBody:%@", __func__, URLString, self.httpBody);
        [manager POST:URLString parameters:self.httpBody progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
            [self handleSuccess:operation response:responseObject];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [self handleFail:operation error:error];
        }];
    } else if ([self requestMethod] == HDRequestMethodUploadFile) {
        [manager POST:URLString parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (NSString *key in self.httpBody) {
                NSDictionary *dict = [self.httpBody objectForKey:key];
                NSData *data = [dict objectForKey:@"data"];
                NSString *name = key;
                NSString *fileName = [dict objectForKey:@"fileName"];
                NSString *mimeType = [dict objectForKey:@"mimeType"];
                if (![data isKindOfClass:[NSData class]] || !name || !mimeType || !fileName) {
                    continue;
                }
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleSuccess:task response:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleFail:task error:error];
        }];
    }
}

- (void)handleSuccess:(NSURLSessionTask*) operation response:(id)responseObject {
    NSLog(@"%@", responseObject);
    self.result = responseObject;//[responseObject objectForKey:@"data"];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:self.didFinishSelector]) {
            SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING( [self.delegate performSelector:self.didFinishSelector withObject:self] );
        }
        return;
    }
}


- (void)handleFail:(NSURLSessionTask*)operation error:(NSError*)error {
    self.error = error;
    NSLog(@"%s----%@", __func__, error);
    //TODO: 设置状态码
    //    self.responseStatus = (int)operation.state
    if (self.delegate && [self.delegate respondsToSelector:self.didFailSelector]) {
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.delegate performSelector:self.didFailSelector withObject:self]);
    }
    
}

- (void)test {
    if ([self kindOfTest] == HDRequestTestTypeSucceeded) {
        [self performSelector:@selector(testSucceeded) withObject:nil afterDelay:[self timeToDelay]];
    }else if([self kindOfTest] == HDRequestTestTypeFailed) {
        [self performSelector:@selector(testFailed) withObject:nil afterDelay:[self timeToDelay]];
    }
    
}

- (void)testSucceeded {
    self.result = [self successResultForTest];
    self.responseStatus = 200;
    if (self.delegate && [self.delegate respondsToSelector:self.didFinishSelector]) {
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.delegate performSelector:self.didFinishSelector withObject:self]);
    }
}

- (void)testFailed {
    self.error = [self errorResultForTest];
    self.responseStatus = 400;
    if (self.delegate && [self.delegate respondsToSelector:self.didFailSelector]) {
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.delegate performSelector:self.didFailSelector withObject:self]);
    }
}

- (int)resultStatus {
    return self.responseStatus;
}
- (NSString*)resultErrorMessage {
    if (self.errorMessage) {
        return self.errorMessage;
    }
    return @"发生未知错误";
}

- (BOOL)requestSucceeded {
    return self.responseStatus == 200;
}

- (void)printObject:(id)object {
    if ([object isKindOfClass:[NSArray class]]) {
        for (id obj  in (NSArray*)object) {
            [self printObject:obj];
        }
        return;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        for (id key in [(NSDictionary *)object allKeys]) {
            [self printObject:key];
            [self printObject:[(NSDictionary *)object objectForKey:key]];
        }
        return;
    }
}

@end
