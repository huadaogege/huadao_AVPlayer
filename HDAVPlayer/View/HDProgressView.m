//
//  HDProgressView.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 17/7/6.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDProgressView.h"

@implementation HDProgressView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.progressView.frame = CGRectMake(0, (frame.size.height - 4.0) / 2.0, frame.size.width, 4.0);
        self.controlDot.frame = CGRectMake(0, (self.progressView.frame.size.height - 12.0) / 2.0, 4.0, 12.0);
        [self.progressView addSubview:self.controlDot];
        [self addSubview:self.progressView];
    }
    return self;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor lightGrayColor];
        _progressView.layer.cornerRadius = 2.0;
    }
    return _progressView;
}

- (UIView *)controlDot {
    if (!_controlDot) {
        _controlDot = [[UIView alloc] init];
        _controlDot.backgroundColor = [UIColor greenColor];
    }
    return _controlDot;
}

- (void)setProgressValue:(CGFloat)progressValue {
    CGFloat X = progressValue * self.progressView.frame.size.width;
    [self updateControlDots:X];
}

- (void)updateControlDots:(CGFloat)value {
    CGFloat X = value;
    CGRect frame = self.controlDot.frame;
    self.controlDot.frame = CGRectMake(X, frame.origin.y, frame.size.width, frame.size.height);
}

#pragma mark -- touchEvent --
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [event.allTouches anyObject];
    CGPoint touchBeginPoint = [touch locationInView:self];
    BOOL locationInDot = CGRectContainsPoint(CGRectMake(self.controlDot.frame.origin.x - 20.0,
                                                        self.controlDot.frame.origin.y - 20.0,
                                                        self.controlDot.frame.size.width + 40.0,
                                                        self.controlDot.frame.size.height + 40.0), touchBeginPoint);
    self.IsMoving = locationInDot;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.IsMoving) {
        UITouch *touch = [event.allTouches anyObject];
        CGPoint movingPoint = [touch locationInView:self];
        CGFloat X = movingPoint.x;
        if (X >= self.progressView.frame.size.width) {
            X = self.progressView.frame.size.width;
        }
        [self updateControlDots:X];
        CGFloat progressView = self.controlDot.frame.origin.x / self.progressView.frame.size.width;
        if (self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(progressMoveToPoint:)]) {
            [self.progressDelegate progressMoveToPoint:progressView];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    CGFloat progressView = self.controlDot.frame.origin.x / self.progressView.frame.size.width;
//    if (self.progressDelegate && [self.progressDelegate respondsToSelector:@selector(progressMoveToPoint:)]) {
//        [self.progressDelegate progressMoveToPoint:progressView];
//    }
}


@end
