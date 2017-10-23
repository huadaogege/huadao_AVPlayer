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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HDFuncViewController *funcViewController = [[HDFuncViewController alloc] init];
    [self initRootViewController:funcViewController];
    [HDConfig videoPlayerSettingWithController:self];
    [self builder];
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

- (void)initRootViewController:(HDViewController *)viewController {
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
