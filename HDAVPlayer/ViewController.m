//
//  ViewController.m
//  HDAVPlayer
//
//  Created by huadao on 17/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "ViewController.h"
#import "HDFuncViewController.h"
#import "HDConfig.h"
#import "HDFmdbManager.h"
#import "HDFactory.h"
#import "HDFactoryMultiply.h"
#import "HDCalculatesMultiply.h"
#import "AudiCar.h"
#import "AudiA8Car.h"
#import "AudiCarBuilder.h"
#import "AudiDirector.h"
#import "HDRequest.h"
#import "HDAppInfoRequest.h"
#import "HDDown.h"
#import "HDDownState.h"
#import "HDDowningState.h"
#import "HDPauseState.h"
#import "HDFinishedState.h"
#import "HDFailedState.h"
#import "HDUploadFileRequest.h"
#import "Request.h"
#import "HDWorkerFactory.h"
#import "HDCashContext.h"

#import "Espresso.h"
#import "Decaf.h"
#import "DarkRoast.h"
#import "Milk.h"
#import "Mocha.h"
#import "Soy.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HDFuncViewController *funcViewController = [[HDFuncViewController alloc] init];
    [self initRootViewController:funcViewController];
    [HDConfig videoPlayerSettingWithController:self];
    [self decorater];
}

/**
 简单工厂模式
 */
- (void)simpleFactory {
    id <HDWorker> worker;
    worker = [HDWorkerFactory workerWithProfessionName:@"Teacher"];
    worker.name = @"huadao";
    [worker WorkProduce];
}

/**
 策略模式
 */
- (void)strategy {
    HDCashContext *normalContext = [[HDCashContext alloc] initWithCashType:CashNormal];
    NSLog(@"%f", [normalContext getCashResult:100]);
    HDCashContext *returnContext = [[HDCashContext alloc] initWithCashType:CashReturn];
    NSLog(@"%f", [returnContext getCashResult:100]);
    HDCashContext *rebateContext = [[HDCashContext alloc] initWithCashType:CashRebate];
    NSLog(@"%f", [rebateContext getCashResult:100]);
}

/**
 装饰模式
 */
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

/**
 代理模式
 */
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

//- (void)requestAppInfo {
//    HDAppInfoRequest *request = (HDAppInfoRequest *)[HDRequest requestWithName:@"appInfoRequest"];
//    request.delegate = self;
//    request.trackId = @"427457043";
//    request.didFinishSelector = @selector(didFinishSelector:);
//    request.didFailSelector = @selector(didFailSelector:);
//    [request start];
//}
//
//- (void)didFinishSelector:(HDRequest *)request {
//    NSArray *array = request.result[@"results"];
//    NSDictionary *dic = [array firstObject];
//    NSLog(@"%@", dic);
//    NSLog(@"version:%@", dic[@"version"]);
//}
//
//- (void)didFailSelector:(HDRequest *)request {
//    NSLog(@"%@", request);
//}



//工厂方法模式
- (void)methodFactory {
    HDFactory *factory = [[HDFactoryMultiply alloc] init];
    id<HDCalculates> calculate = [factory createFactory];
    calculate.number_A = 10;
    calculate.number_B = 2;
    NSLog(@"%f", [calculate calculate]);
}

- (void)builder {
    //carBuilder:建造者, AudiDirector:汽车销售员
    AudiCarBuilder *carBuilder = [[AudiA8Car alloc] init];
    AudiCar *car = [AudiDirector creatBuickCar:carBuilder];
    NSLog(@"%@", [car description]);
    
}

/**
 状态模式
 */
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

- (void)initRootViewController:(HDViewController *)viewController {
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
