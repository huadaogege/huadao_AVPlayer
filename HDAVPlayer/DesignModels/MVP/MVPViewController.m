//
//  MVPViewController.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/28.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "MVPViewController.h"
#import "Presenter.h"
#import "MVPModel.h"
#import "MVPView.h"

@interface MVPViewController ()

@property (nonatomic, strong) Presenter *presenter;

@property (nonatomic, strong) MVPModel *mvpModel;

@property (nonatomic, strong) MVPView *mvpView;

@end

@implementation MVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.presenter = [[Presenter alloc] init];
    
    self.mvpView = [[MVPView alloc] init];
    self.mvpView.frame = self.view.frame;
    [self.view addSubview:self.mvpView];
    
    self.mvpModel = [[MVPModel alloc] init];
    self.mvpModel.content = @"line 0";
    
    self.presenter.mvpModel = self.mvpModel;
    self.presenter.mvpView = self.mvpView;
    [self.presenter printOpreate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
