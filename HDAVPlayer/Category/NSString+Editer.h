//
//  NSString+Editer.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 17/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Editer)

/**
 获取随机字符串

 @return 随机字符串
 */

/**
获取随机字符串

 @param length 随机字符串长度
 @param spackMark 间隔符
 @return 随机字符串
 */
+ (NSString *)randomStringLength:(int)length spackMark:(NSString*)spackMark;
@end
