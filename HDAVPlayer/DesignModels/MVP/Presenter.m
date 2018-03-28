//
//  Presenter.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/28.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "Presenter.h"

@implementation Presenter

- (void)printOpreate {
    NSString *content = self.mvpModel.content;
    [self.mvpView printContent:content];
}

@end
