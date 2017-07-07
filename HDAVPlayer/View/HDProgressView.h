//
//  HDProgressView.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 17/7/6.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HDProgressViewDelegate <NSObject>

- (void)progressMoveToPoint:(CGFloat)value;

@end

@interface HDProgressView : UIView

@property (strong, nonatomic) UIView *controlDot;

@property (strong, nonatomic) UIView *progressView;

@property (assign, nonatomic) CGFloat progressValue;

@property (assign, nonatomic) BOOL IsMoving;

@property (weak, nonatomic) id<HDProgressViewDelegate>progressDelegate;

@end
