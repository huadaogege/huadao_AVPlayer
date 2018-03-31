//
//  MVVMViewController.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/31.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVVMViewModel.h"
#import "MVVMView.h"
#import "MVVMModel.h"

@interface MVVMViewController ()

@property (nonatomic, strong) MVVMViewModel *viewModel;
@property (nonatomic, strong) MVVMModel *model;
@property (nonatomic, strong) MVVMView *mvvmView;

@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [MVVMModel new];
    _model.contentStr = @"line 0";
    
    self.mvvmView = [MVVMView new];
    _mvvmView.frame = self.view.frame;
    [self.view addSubview:_mvvmView];
    
    self.viewModel = [MVVMViewModel new];
    [_viewModel setWithModel:_model];
    [_mvvmView setWithViewModel:_viewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
