//
//  HDImageListViewController.m
//  HDAVPlayer
//
//  Created by huadao on 2017/11/21.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDImageListViewController.h"
#import "HDImageManager.h"
#import "imageListCell.h"
#import "HDImageViewModel.h"

@interface HDImageListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HDImageViewModel *viewModel;

@end

@implementation HDImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"imageListCell" bundle:nil] forCellReuseIdentifier:@"imageListCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.viewModel = [[HDImageViewModel alloc] init];
    self.viewModel.viewController = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel prepareImageData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel tableView:tableView numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSectionsInTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
