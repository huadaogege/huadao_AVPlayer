//
//  HDCoreAnimationViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/26.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "HDCoreAnimationViewController.h"

@interface HDCoreAnimationViewController ()

@end

@implementation HDCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)doAnimation:(id)sender {
    [self doAnimation];
}

// 1.平移动画
- (void)translateAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 200)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(Screen_width, 200)];
    animation.duration = 2.0;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.demoImageView.layer addAnimation:animation forKey:@"translateAnimation"];
}

/**
 2.透明度动画
 */
- (void)opacityAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithInt:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.1];
    animation.duration = 2.0;
    animation.fillMode = kCAFillModeRemoved;
    animation.removedOnCompletion = NO;
    [self.demoImageView.layer addAnimation:animation forKey:@"opacityAnimation"];
}

/**
 3.缩放
 */
- (void)zoomAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithInt:1.0];
    animation.toValue = [NSNumber numberWithInt:3.0];
    animation.duration = 3.0;
    animation.fillMode = kCAFillModeRemoved;
    animation.removedOnCompletion = NO;
    [self.demoImageView.layer addAnimation:animation forKey:@"zoomAnimation"];
}

/**
 4.旋转动画
 */
- (void)transformAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
    animation.duration = 5.0;
    animation.repeatCount = MAXFLOAT;
    [self.demoImageView.layer addAnimation:animation forKey:@"transformAnimation"];
    [self performSelector:@selector(removeAnimation) withObject:nil afterDelay:6.0];
}

/**
 5.关键帧动画
 */
- (void)keyPathAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, 200)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(Screen_width/5, 400)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(Screen_width*2/5, 200)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(Screen_width*3/5, 300)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(Screen_width*4/5, 150)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(Screen_width, 350)];
    animation.values = @[value0, value1, value2, value3, value4, value5];
    animation.duration = 5.0;
    animation.repeatCount = MAXFLOAT;
    [self.demoImageView.layer addAnimation:animation forKey:@"keyPathAnimation"];
    [self performSelector:@selector(removeAnimation) withObject:nil afterDelay:15.0];
}

/**
 6.路径动画
 */
- (void)pathAnimation {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(Screen_width/2 - 100, Screen_height/2 - 100, 200, 200)];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = bezierPath.CGPath;
    animation.duration = 3.0;
    animation.repeatCount = 3;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.demoImageView.layer addAnimation:animation forKey:@"pathAnimation"];
}

/**
 7.抖动动画
 */
- (void)shakeAnimation {
    CAKeyframeAnimation *kAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*16];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*16];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*16];
    kAnimation.values = @[value1,value2,value3];
    kAnimation.repeatCount = MAXFLOAT;
    [self.demoImageView.layer addAnimation:kAnimation forKey:@"shakeAnimation"];
}

/**
 8.组动画（同时）
 */
- (void)groupAnimation {
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, Screen_height/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(Screen_width/3, Screen_height/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(Screen_width/3, Screen_height/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(Screen_width*2/3, Screen_height/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(Screen_width*2/3, Screen_height/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(Screen_width, Screen_height/2-50)];
//    anima1.duration = 2.0f;
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏

    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
//    anima2.duration = 1.0f;

    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
//    anima3.duration = 1.0;

    //组动画
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.animations = @[anima1, anima2, anima3];
    animaGroup.duration = 4.0f;
    [self.demoImageView.layer addAnimation:animaGroup forKey:@"animationGroup"];
}

/**
 9.连续动画组
 */
- (void)continueAnimation {
    CFTimeInterval currentTime = CACurrentMediaTime();
    //位移动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, Screen_height/2-75)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(Screen_width/2, Screen_height/2-75)];
    anima1.beginTime = currentTime;
    anima1.duration = 1.0f;
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = NO;
    [self.demoImageView.layer addAnimation:anima1 forKey:@"aa"];

    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime+1.0f;
    anima2.duration = 2.0f;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = NO;
    [self.demoImageView.layer addAnimation:anima2 forKey:@"bb"];

    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime+3.0f;
    anima3.duration = 2.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [self.demoImageView.layer addAnimation:anima3 forKey:@"cc"];
    
    //抖动动画
    CAKeyframeAnimation *kAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*16];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*16];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*16];
    NSValue *value4 = [NSNumber numberWithFloat:0];
    kAnimation.beginTime = currentTime+5.0f;
    kAnimation.values = @[value1,value2,value3,value4];
    kAnimation.duration = 2.0f;
    kAnimation.fillMode = kCAFillModeForwards;
    kAnimation.removedOnCompletion = NO;
    [self.demoImageView.layer addAnimation:kAnimation forKey:@"shakeAnimation"];
}

/**
 10.弧形弹出动画（实现方式:组合动画）
 */
- (void)popAnimation {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIImageView class]] && view.tag != 1010) {
            [view removeFromSuperview];
        }
    }
    NSMutableArray *demoViews = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        UIImageView * demoView = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_width - 20)/2, (Screen_height - 20)/2,20 , 20)];
        demoView.backgroundColor = [UIColor cyanColor];
        demoView.layer.cornerRadius = 10;
        demoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]];
        [self.view addSubview:demoView];
        [demoViews addObject:demoView];
    }
    CGFloat angleUnit = 180.0 / (demoViews.count + 1);
    for (int i = 0; i < demoViews.count; i ++) {
        CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.values = @[@(0.0), @(- M_PI), @(- M_PI * 1.5), @(- M_PI * 2)];
        rotationAnimation.duration = 1.0f;
        rotationAnimation.keyTimes = @[@(0.0), @(0.3), @(0.6), @(1.0)];

        CAKeyframeAnimation *movingAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        CGFloat angle = angleUnit * (i + 1) / 180.0;
        CGPoint farPoint = [self radiusLength:140 angle:angle];
        CGPoint nearPoint = [self radiusLength:60 angle:angle];
        CGPoint endPoint = [self radiusLength:100 angle:angle];

        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, self.demoImageView.center.x, self.demoImageView.center.y);
        CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y);
        CGPathAddLineToPoint(path, NULL, nearPoint.x, nearPoint.y);
        CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
        movingAnimation.path = path;
        movingAnimation.keyTimes = @[@(0.0), @(0.5), @(0.7), @(1.0)];
        movingAnimation.duration = 1.0f;
        CGPathRelease(path);

        CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
        animaGroup.animations = @[rotationAnimation, movingAnimation];
        animaGroup.duration = 1.0f;
        animaGroup.removedOnCompletion = NO;
        animaGroup.fillMode = kCAFillModeForwards;
        UIImageView *imageV = demoViews[i];
        [imageV.layer addAnimation:animaGroup forKey:@"animation1"];
    }
}

- (CGPoint)radiusLength:(CGFloat)radius angle:(CGFloat)angle {
    return CGPointMake(self.demoImageView.center.x + radius * cosf(angle * M_PI), self.demoImageView.center.y - radius * sinf(angle *M_PI));
}

/**
 11.竖直弹出动画（实现方式:组合动画）
 */
- (void)doAnimation {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIImageView class]] && view.tag != 1010) {
            [view removeFromSuperview];
        }
    }
    NSMutableArray *demoViews = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        UIImageView * demoView = [[UIImageView alloc] initWithFrame:CGRectMake((Screen_width - 20)/2, (Screen_height - 20)/2,20 , 20)];
        demoView.backgroundColor = [UIColor cyanColor];
        demoView.layer.cornerRadius = 10;
        demoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]];
        [self.view addSubview:demoView];
        [demoViews addObject:demoView];
    }
    for (int i = 0; i < demoViews.count; i ++) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = 1.0;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.01f];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.f];
        scaleAnimation.beginTime = CACurrentMediaTime() + (1.0/(float)5 * (float)i) + 0.03f;
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;

        CAKeyframeAnimation *movingAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        CGPoint farPoint = [self radiusLength:30*i + 30 angle:0.5];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, self.demoImageView.center.x, self.demoImageView.center.y);
        CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y);
        movingAnimation.path = path;
        movingAnimation.keyTimes = @[@(0.0), @(0.5)];
        movingAnimation.duration = 1.0f;
        CGPathRelease(path);

        CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
        animaGroup.animations = @[scaleAnimation, movingAnimation];
        animaGroup.duration = 1.0f;
        animaGroup.removedOnCompletion = NO;
        animaGroup.fillMode = kCAFillModeForwards;
        UIImageView *imageV = demoViews[i];
        [imageV.layer addAnimation:animaGroup forKey:@"animation1"];
    }
}

- (void)removeAnimation {
    [self.demoImageView.layer removeAllAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
