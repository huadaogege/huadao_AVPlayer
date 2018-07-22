//
//  CEncryptManager.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/4/6.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CEncryptManager : NSObject

+ (CEncryptManager *)shareInstance;

+ (NSString *)base64EncryptPathWithDecryptPath:(NSString *)decryptPath;
+ (NSString *)base64DecryptPathWithEncryptPath:(NSString *)encryptPath;

- (NSError*)aesDecrypt:(NSString*)srcPath to:(NSString*)destPath key:(NSString*)key;
- (NSError*)aesEncrypt:(NSString*)srcPath to:(NSString*)destPath key:(NSString*)key;

- (void)generateRSAKeyPair:(int)keySize;
- (void)testRSAEncryptAndDecrypt;

@end
