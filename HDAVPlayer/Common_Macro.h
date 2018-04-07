//
//  Common_Macro.h
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#ifndef Common_Macro_h
#define Common_Macro_h

#ifdef __OBJC__

#import "LogUtil.h"
#endif

//消除performSelector警告
#define Wipe_Perform_Selector_leak(code) { _Pragma("clang diagnostic push")\
_Pragma("diagnostic ignored \"-Warc-performSelector-leaks\"")\
code;\
_Pragma("clang diagnostic pop")}

//弱引用self
#define weakSelf(weakSelf) __weak __typeof(&*self) weakSelf = self;
//颜色
#define COLOR(r, g, b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]
#define COLOR_HEX(hex) [UIColor colorWithRed:(0xff0000&hex)/255.f green:(0xff00&hex)/255.f blue:(0xff&hex)/255.f alpha:1]
//沙盒目录
#define Document_Path NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
//screen bounds
#define Screen_height [UIScreen mainScreen].bounds.size.height
#define Screen_width [UIScreen mainScreen].bounds.size.width
//屏幕适配比例
#define WINDOW_SCALE Screen_width / 320.0
#define WINDOW_SCALE_SIX Screen_width / 375.0
//二维码标识
#define QRCodeImageIdentifier @"CIQRCodeGenerator"

#endif /* Common_Macro_h */
