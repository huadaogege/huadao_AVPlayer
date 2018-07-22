//
//  CKeyChain.m
//  Tools
//
//  Created by 崔玉冠 on 2018/4/5.
//  Copyright © 2018年 360CompanySafe. All rights reserved.
//

#import "CKeyChain.h"

@implementation CKeyChain

static id instance = nil;

+ (CKeyChain *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CKeyChain alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)copy {
    return instance;
}

+ (NSMutableDictionary *)getChainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:(__bridge_transfer id)kSecClassGenericPassword, kSecClass,
                                                             service, kSecAttrService,
                                                             service, kSecAttrAccount,
                                                             kSecAttrAccessibleAfterFirstUnlock, kSecAttrAccessible,
                                                             nil];
}

/**
 写入

 @param service id
 @param data data
 */
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keyChainQuery = [self getChainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keyChainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keyChainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keyChainQuery, NULL);
}

/**
 读取

 @param service id
 @return ret
 */
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keyChainQuery = [self getChainQuery:service];
    //Configure the search setting
    /*Since in our simple case we are expecting only a single attribute to be returned
    (the password) we can set attribute kSecReturnData to kCFBooleanTrue            */
    [keyChainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keyChainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keyChainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed : %@", service, e);
        } @finally {
            
        }
    }
    if (keyData) {
        CFRelease(keyData);
    }
    return ret;
}

/**
 删除

 @param service id
 */
+ (void)delete:(NSString *)service {
    NSMutableDictionary *keyChainQuery = [self getChainQuery:service];
    SecItemDelete((CFDictionaryRef)keyChainQuery);
}























@end
