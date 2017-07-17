//
//  HDFileListViewController.m
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDFileListViewController.h"
#import "HDFileViewCell.h"
#import "HDFileManager.h"
#import "HDDatabaseManager.h"
#import "MJRefresh.h"
#import "HDPlayerViewController.h"
#import "HDJSONRequest.h"
#import "HDJSONModel.h"
#import "HDVideoViewModel.h"

#define Cell_Identifier @"__filelistcellidentifier"

@interface HDFileListViewController () 

@property (nonatomic, strong) HDVideoViewModel *videoViewModel;

@end

@implementation HDFileListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoViewModel = [[HDVideoViewModel alloc] init];
    self.videoViewModel.vieController = self;
    MJRefreshNormalHeader *freshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.videoViewModel fetchFileData];
        [self.videoViewModel.tableView.mj_header endRefreshing];
    }];
    self.videoViewModel.tableView.mj_header = freshHeader;
    [self.view addSubview:self.videoViewModel.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.videoViewModel fetchFileData];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.videoViewModel tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.videoViewModel tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.videoViewModel tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.videoViewModel tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.videoViewModel tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.videoViewModel tableView:tableView canEditRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.videoViewModel tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
