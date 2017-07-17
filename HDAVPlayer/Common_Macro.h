//
//  Common_Macro.h
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#ifndef Common_Macro_h
#define Common_Macro_h

#define Screen_height [UIScreen mainScreen].bounds.size.height
#define Screen_width [UIScreen mainScreen].bounds.size.width

#define Document_Path NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#define QRCodeImageIdentifier @"CIQRCodeGenerator"

#define WeakSelf __weak typeof(self) weakSelf = self;

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;


#endif /* Common_Macro_h */
