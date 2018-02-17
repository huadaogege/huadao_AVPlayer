//
//  HDCalculates.h
//  HDAVPlayer
//
//  Created by huadao on 2017/10/23.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HDCalculates <NSObject>

@property (nonatomic) CGFloat number_A;

@property (nonatomic) CGFloat number_B;

- (CGFloat)calculate;

@end
