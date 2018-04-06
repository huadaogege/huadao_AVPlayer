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
#import "HDRequest.h"
#import "HDAppInfoRequest.h"
#import "DesignModes.h"
#import "Arithmetics.h"
#import "CKeyChain.h"

NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";
NSString * const KEY_USERNAME = @"com.company.app.username";
NSString * const KEY_PASSWORD = @"com.company.app.password";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DesignModes *designMode = [[DesignModes alloc] init];
    [designMode designModa];
    //keyChain 使用范式
    NSMutableDictionary *userNamePasswordDic = [[NSMutableDictionary alloc] init];
    [userNamePasswordDic setObject:@"cuiyugaun" forKey:KEY_USERNAME];
    [userNamePasswordDic setObject:@"cyg08212611" forKey:KEY_PASSWORD];
    [CKeyChain save:KEY_USERNAME_PASSWORD data:userNamePasswordDic];
    NSMutableDictionary *readUsernamePassword = (NSMutableDictionary *)[CKeyChain load:KEY_USERNAME_PASSWORD];
    NSString *userName = [readUsernamePassword objectForKey:KEY_USERNAME];
    NSString *password = [readUsernamePassword objectForKey:KEY_PASSWORD];
    
}

- (void)initRootViewController:(HDViewController *)viewController {
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
