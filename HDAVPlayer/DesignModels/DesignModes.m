//
//  DesignModes.m
//  HDAVPlayer
//
//  Created by huadao on 2018/2/8.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "DesignModes.h"
#import "HDUploadFileRequest.h"
#import "HDFactory.h"
#import "HDFactoryMultiply.h"
#import "HDCalculatesMultiply.h"
#import "Request.h"
#import "HDDown.h"
#import "HDDownState.h"
#import "HDDowningState.h"
#import "HDPauseState.h"
#import "HDFinishedState.h"
#import "HDFailedState.h"
#import "HDWorkerFactory.h"
#import "HDCashContext.h"
#import "SonyCameraBuilder.h"
#import "SonyA9.h"
#import "SonyCameraDirector.h"
#import "Espresso.h"
#import "Decaf.h"
#import "DarkRoast.h"
#import "Milk.h"
#import "Mocha.h"
#import "Soy.h"
#import "MVPViewController.h"
#import "MVVMViewController.h"

@implementation DesignModes

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)designModa {
    [self mvvmModels];
}

#pragma mark -- 1.简单工厂模式 --
- (void)simpleFactory {
    id <HDWorker> worker;
    worker = [HDWorkerFactory workerWithProfessionName:@"Teacher"];
    worker.name = @"huadao";
    [worker WorkProduce];
}

#pragma mark -- 2.策略模式 --
- (void)strategy {
    HDCashContext *normalContext = [[HDCashContext alloc] initWithCashType:CashNormal];
    NSLog(@"%f", [normalContext getCashResult:100]);
    HDCashContext *returnContext = [[HDCashContext alloc] initWithCashType:CashReturn];
    NSLog(@"%f", [returnContext getCashResult:100]);
    HDCashContext *rebateContext = [[HDCashContext alloc] initWithCashType:CashRebate];
    NSLog(@"%f", [rebateContext getCashResult:100]);
}

#pragma mark -- 3.装饰模式 --
- (void)decorater {
    id <Component> espresso = [[Espresso alloc] init];
    espresso = [[Milk alloc] initWithComponent:espresso];
    espresso = [[Mocha alloc] initWithComponent:espresso];
    NSLog(@"品名:卡布奇诺->配料:%@->售价:%f", [espresso getName], [espresso getCost]);
    
    id <Component> darkRoast = [[DarkRoast alloc] init];
    darkRoast = [[Mocha alloc] initWithComponent:darkRoast];
    darkRoast = [[Milk alloc] initWithComponent:darkRoast];
    darkRoast = [[Soy alloc] initWithComponent:darkRoast];
    NSLog(@"品名:拿铁->配料:%@->售价:%f", [darkRoast getName], [darkRoast getCost]);
}

#pragma mark -- 4.代理模式 --
- (void)delegateDesignMode {
    Request *request = [[Request alloc] requestWithUrlId:@"007"];
    request.delegate = self;
    request.didFisishSelector = @selector(didFisishSelector:);
    request.didFailedSelector = @selector(didFailedSelector:);
    [request start];
}

- (void)didFisishSelector:(Request *)request {
    NSLog(@"请求成功:%@", request.requestId);
}

- (void)didFailedSelector:(Request *)request {
    NSLog(@"请求失败:%@", request.requestId);
}

#pragma mark -- 5.建造者模式 --
- (void)builder {
    SonyCameraBuilder *builder = [[SonyA9 alloc] init];
    SonyCamera *camera = [SonyCameraDirector createCameraWithBuildr:builder];
    NSLog(@"%@", [camera description]);
}

#pragma mark -- 6.工厂方法模式 --
- (void)methodFactory {
    id<HDCalculates> factory = [HDFactoryMultiply createFactory];
    factory.number_A = 10;
    factory.number_B = 2;
    NSLog(@"%f", [factory calculate]);
}

#pragma mark -- 7.状态模式 --
- (void)states {
    HDDown *down = [[HDDown alloc] init];
    [down updateDownOperation];
    down.state = [[HDDowningState alloc] init];
    [down updateDownOperation];
    down.state = [[HDPauseState alloc] init];
    [down updateDownOperation];
    down.state = [[HDFailedState alloc] init];
    [down updateDownOperation];
    down.state = [[HDFinishedState alloc] init];
    [down updateDownOperation];
}

#pragma mark -- 8.mvp设计模式
- (void)mvpModels {
    MVPViewController * mvp = [[MVPViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mvp;
}

- (void)mvvmModels {
    MVVMViewController * mvvm = [[MVVMViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mvvm;
}

@end
