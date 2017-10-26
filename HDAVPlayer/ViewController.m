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
#import "HDCalculateFactory.h"
#import "HDStrategyController.h"
#import "Espresso.h"
#import "Milk.h"
#import "Mocha.h"
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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HDFuncViewController *funcViewController = [[HDFuncViewController alloc] init];
    [self initRootViewController:funcViewController];
    [HDConfig videoPlayerSettingWithController:self];
}

- (void)requestAppInfo {
    HDAppInfoRequest *request = (HDAppInfoRequest *)[HDRequest requestWithName:@"appInfoRequest"];
    request.delegate = self;
    request.trackId = @"427457043";
    request.didFinishSelector = @selector(didFinishSelector:);
    request.didFailSelector = @selector(didFailSelector:);
    [request start];
}

- (void)didFinishSelector:(HDRequest *)request {
    NSArray *array = request.result[@"results"];
    NSDictionary *dic = [array firstObject];
    NSLog(@"%@", dic);
    NSLog(@"version:%@", dic[@"version"]);
}

- (void)didFailSelector:(HDRequest *)request {
    NSLog(@"%@", request);
}


//简单工厂模式
- (void)simpleFactory {
    id<HDCalculate> cal;
    cal = [HDCalculateFactory createCalculate:@"*"];
    cal.numberA = 10;
    cal.numberB = 2;
    CGFloat result = [cal calculate];
    NSLog(@"%f", result);
}

//策略模式
- (void)strategy {
    HDStrategyController *vc = [[HDStrategyController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//装饰者模式
- (void)decorator {
    id<ComponentProtocol> component = [[Espresso alloc] init];
    NSLog(@"%@:%f",[component getName], [component cost]);
    component = [[Milk alloc] initWithComponent:component];
    NSLog(@"%@:%f",[component getName], [component cost]);
    component = [[Mocha alloc] initWithComponent:component];
    NSLog(@"%@:%f",[component getName], [component cost]);
}

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
