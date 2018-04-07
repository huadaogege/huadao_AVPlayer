//
//  CEncryptManager.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/4/6.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "CEncryptManager.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>
#import "uuaes.h"
#import <Security/Security.h>

#define kRSA_KEY_SIZE 1024
@implementation CEncryptManager {
    SecKeyRef publicKeyRef;//公钥
    SecKeyRef privateKeyRef;//私钥
}

static unsigned char _iv[16];

static id instance = nil;

+ (CEncryptManager *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CEncryptManager alloc] init];
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

#pragma mark -- base64 --
/**
 将文件加密

 @param decryptPath 原始文件路径
 @return 加密之后文件路径
 */
+ (NSString *)base64EncryptPathWithDecryptPath:(NSString *)decryptPath {
    NSData *decryptData = [NSData dataWithContentsOfFile:decryptPath];
    NSData *base64Data = [decryptData base64EncodedDataWithOptions:0];
    NSString *encryptPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"111encrypt.png"];
    [base64Data writeToFile:encryptPath atomically:YES];
    return encryptPath;
}

/**
 将文件解密

 @param encryptPath 加密文件路径
 @return 解密文件路径
 */
+ (NSString *)base64DecryptPathWithEncryptPath:(NSString *)encryptPath {
    NSData *encryptData = [NSData dataWithContentsOfFile:encryptPath];
    NSData *base64Data = [[NSData alloc] initWithBase64EncodedData:encryptData options:0];
    NSString *decryptPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"111Dencrypt.png"];
    [base64Data writeToFile:decryptPath atomically:YES];
    return decryptPath;
}

#pragma mark -- AES:Advanced Encryption Standard 对称加解密 --

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(unsigned char[16]) iv data:(NSData*)data {
    unsigned char * keyTmp = (unsigned char*)malloc(sizeof(unsigned char) *kCCKeySizeAES128);
    const char *keyChar = [key cStringUsingEncoding:NSUTF8StringEncoding];
    memcpy(keyTmp, keyChar, sizeof(unsigned char) *kCCKeySizeAES128);
    
    int keysize = 128;
    aes_context aes;
    
    aes_setkey_enc(&aes, (unsigned char*)keyTmp, keysize);
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    unsigned char* buffer = (unsigned char*)malloc(sizeof(unsigned char)*bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t inBufferSize = dataLength + (dataLength%16?(16-dataLength%16):0);
    unsigned char* inBuffer = (unsigned char*)malloc(sizeof(unsigned char)*inBufferSize);
    memset(inBuffer, 0, inBufferSize);
    memcpy(inBuffer, [data bytes], dataLength);
    
    int ret = aes_crypt_cbc(&aes, AES_ENCRYPT, inBufferSize, iv, inBuffer, buffer);
    memset(&aes, 0, sizeof(aes));
    free(keyTmp);
    free(inBuffer);
    if (ret < 0) {
        free(buffer);
        return nil;
    }
    NSData *encryptData = [NSData dataWithBytes:buffer length:inBufferSize];
    free(buffer);
    return encryptData;
}

- (NSData *)AES128DecryptWithKey:(NSString *)key  iv:(unsigned char[16]) iv data:(NSData*)data {
    unsigned char * keyTmp = (unsigned char*)malloc(sizeof(unsigned char) *kCCKeySizeAES128);
    const char *keyChar = [key cStringUsingEncoding:NSUTF8StringEncoding];
    memcpy(keyTmp, keyChar, sizeof(unsigned char) *kCCKeySizeAES128);
    int keysize = 128;
    aes_context aes;
    aes_setkey_dec(&aes, (unsigned char*)keyTmp, keysize);
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    unsigned char* buffer = (unsigned char*)malloc(sizeof(unsigned char)*bufferSize);
    memset(buffer, 0, bufferSize);
    int ret = aes_crypt_cbc(&aes, AES_DECRYPT, dataLength, iv, (unsigned char*)[data bytes], buffer);
    free(keyTmp);
    if (ret < 0) {
        free(buffer);
        return nil;
    }
    NSData *decryptData = [NSData dataWithBytes:buffer length:dataLength];
    free(buffer);
    return decryptData;
}


- (NSError*)crypt:(NSString*)srcPath to:(NSString*)destPath key:(NSString*)key block:(NSData*(^)(NSData*))block {
    NSAssert(srcPath && destPath, @"Source path or dest path nil.");
    NSError *error;
    NSFileHandle *fileRead = [NSFileHandle fileHandleForReadingFromURL:[NSURL fileURLWithPath:srcPath] error:&error];
    if (!fileRead) {
        return error;
    }
    NSFileHandle *fileWrite = [NSFileHandle fileHandleForWritingToURL:[NSURL fileURLWithPath:destPath] error:&error];
    if (!fileWrite) {
        [[NSFileManager defaultManager] createFileAtPath:destPath contents:nil attributes:nil];
        fileWrite = [NSFileHandle fileHandleForWritingAtPath:destPath];
    } else {
        [fileWrite truncateFileAtOffset:0];
    }
    if (!fileWrite) {
        return [NSError errorWithDomain:@"Create dest file failed." code:-1 userInfo:@{}];
    }
    @try {
        [fileRead seekToFileOffset:0];
        [fileWrite seekToFileOffset:0];
        NSData *data = [fileRead readDataOfLength:1024];
        while (data.length>0) {
            @autoreleasepool {
                CCCryptorStatus status = kCCSuccess;
                NSData *decryptedData = nil;
                if (block) {
                    decryptedData = block(data);
                }
                if ( !decryptedData||status!= kCCSuccess) {
                    NSLog(@"Failed.");
                    return [NSError errorWithDomain:@"crypt failed." code:status userInfo:nil];
                }
                [fileWrite writeData:decryptedData];
                data = nil;
                data = [fileRead readDataOfLength:1024*1024];
            }
        }
        data = nil;
        [fileWrite synchronizeFile];
    } @catch (NSException *exception) {
        return [NSError errorWithDomain:exception.description code:-1 userInfo:nil];
    } @finally {
        if (fileRead) {
            [fileRead closeFile];
        }
        if (fileWrite) {
            [fileWrite closeFile];
        }
    }
    return nil;
}

- (NSError*)aesEncrypt:(NSString*)srcPath to:(NSString*)destPath key:(NSString*)key {
    unsigned char ivTemp[16] = { 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8};
    memcpy(_iv, ivTemp, sizeof(_iv));
    return  [self crypt:srcPath to:destPath key:key block:^NSData *(NSData *data) {
        return [self AES128EncryptWithKey:key iv:_iv data:data];
    }];
}

- (NSError*)aesDecrypt:(NSString*)srcPath to:(NSString*)destPath key:(NSString*)key {
    unsigned char ivTemp[16] = { 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8};
    memcpy(_iv, ivTemp, sizeof(_iv));
    return  [self crypt:srcPath to:destPath key:key block:^NSData *(NSData *data) {
        return [self AES128DecryptWithKey:key iv:_iv data:data];
    }];
}

#pragma mark -- RSA:非对称加解密 --

//生成RSA密钥对，公钥和私钥，支持的SIZE有
// sizes for RSA keys are: 512, 768, 1024, 2048.
- (void)generateRSAKeyPair:(int)keySize {
    OSStatus ret = 0;
    publicKeyRef = NULL;
    privateKeyRef = NULL;
    ret = SecKeyGeneratePair((CFDictionaryRef)@{(id)kSecAttrKeyType:(id)kSecAttrKeyTypeRSA,
                                                (id)kSecAttrKeySizeInBits:@(keySize)},
                             &publicKeyRef,
                             &privateKeyRef);
    NSAssert(ret==errSecSuccess, @"秘钥对生成失败:%d", (int)ret);
    NSLog(@"publicKey:::%@", publicKeyRef);
    NSLog(@"privateKey:::%@", privateKeyRef);
    NSLog(@"max size:%lu", SecKeyGetBlockSize(privateKeyRef));
}

- (void)testRSAEncryptAndDecrypt {
    [self generateRSAKeyPair:kRSA_KEY_SIZE];
    NSString *srcString = @"cyg08212611";
    NSData *srcData = [srcString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"预主秘钥data:%@->key:%@", srcData, srcString);
    uint8_t encData[kRSA_KEY_SIZE/8] = {0};
    uint8_t decData[kRSA_KEY_SIZE/8] = {0};
    size_t blockSize = kRSA_KEY_SIZE / 8;
    OSStatus ret;
    //公钥加密预主秘钥
    ret = SecKeyEncrypt(publicKeyRef, kSecPaddingNone, srcData.bytes, srcData.length, encData, &blockSize);
    NSAssert(ret==errSecSuccess, @"加密失败");
    //私钥解密预主秘钥
    ret = SecKeyDecrypt(privateKeyRef, kSecPaddingNone, encData, blockSize, decData, &blockSize);
    NSAssert(ret==errSecSuccess, @"解密失败");
    
    NSData *dedData = [NSData dataWithBytes:decData length:blockSize];
    NSLog(@"dec:%@",dedData);
    if (memcmp(srcData.bytes, dedData.bytes, srcData.length)==0) {
        NSLog(@"PASS");
    }
}



@end
