//
//  HDFuncViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDFuncViewController.h"
#import "HDFuncViewModel.h"
#import "HDJSONRequest.h"
#import "HDRequest.h"

#define Cell_Identifier @"__funclistcellidentifier"

@interface HDFuncViewController ()

@property (nonatomic, strong) HDFuncViewModel *funcViewModel;

@end

@implementation HDFuncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.funcViewModel = [[HDFuncViewModel alloc] init];
    self.funcViewModel.vieController = self;
    [self.view addSubview:self.funcViewModel.tableView];
    HDJSONRequest*request = (HDJSONRequest *)[HDRequest requestWithName:@"jsonRequest"];
    request.delegate = self;
//    request.httpBody = @{@"name":@"cuiyuguan"};
    request.didFinishSelector = @selector(jsonDidFinishSelector:);
    request.didFailSelector = @selector(jsonDidFailSelector:);
    [request start];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.funcViewModel numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.funcViewModel tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.funcViewModel tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.funcViewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.funcViewModel tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)jsonDidFinishSelector:(HDRequest *)request {
    NSLog(@"%@", request.result);
}

- (void)jsonDidFailSelector:(HDRequest *)request {
    NSLog(@"%@", request.result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
