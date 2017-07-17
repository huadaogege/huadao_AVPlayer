//
//  HDConfig.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HDConfig : NSObject

+ (HDConfig *)shareInsatnce;

@property (nonatomic, assign) BOOL openSecrect;

+ (void)videoPlayerSettingWithController:(UIViewController*)controller;

@end
