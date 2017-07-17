//
//  HDConfig.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDConfig.h"

@implementation HDConfig

+ (HDConfig *)shareInsatnce {
    static HDConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[HDConfig alloc] init];
    });
    return config;
}

+ (void)videoPlayerSettingWithController:(UIViewController*)controller {
    controller.title = @"功能列表";
    [[HDConfig shareInsatnce] initControlBarItemWithController:controller];
}

- (void)initControlBarItemWithController:(UIViewController *)controller {
    UITapGestureRecognizer *openGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(open)];
    openGesture.numberOfTapsRequired = 5;
    UIView *leftlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftlView addGestureRecognizer:openGesture];
    
    UITapGestureRecognizer *closeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    closeGesture.numberOfTapsRequired = 4;
    UIView *rightlView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightlView addGestureRecognizer:closeGesture];
    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftlView];
    controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightlView];
}

- (void)open {
    self.openSecrect = YES;
}

- (void)close {
    self.openSecrect = NO;
}


@end
