//
//  UIAlertController+Editer.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/18.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Editer)
typedef NS_ENUM(NSInteger, clickIndex) {
    leftIndex = 0,
    rightIndex
};

+ (UIAlertController *_Nullable)alertViewControllerWithTile:(NSString *_Nullable)title
                                                    message:(NSString *_Nullable)message
                                                  leftTitle:(NSString *_Nullable)leftTitle
                                                 rightTitle:(NSString *_Nullable)rightTitle
                                                     hander:(void(^_Nullable)(clickIndex index))hander;

@end
