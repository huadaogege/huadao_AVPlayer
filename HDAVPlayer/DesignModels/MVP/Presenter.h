//
//  Presenter.h
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/28.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVPModel.h"
#import "MVPView.h"

@interface Presenter : NSObject

@property (nonatomic, strong) MVPModel *mvpModel;

@property (nonatomic, strong) MVPView *mvpView;

- (void)printOpreate;

@end
