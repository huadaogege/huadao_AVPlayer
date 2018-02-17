//
//  HDVideoViewModel.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDVideoViewModel.h"
#import "HDFileManager.h"
#import "HDFileViewCell.h"
#import "HDPlayerViewController.h"
#import "MJRefresh.h"
#import "UIAlertController+Editer.h"
#import "VideoViewController.h"

#define Cell_Identifier @"__filelistcellidentifier"

@implementation HDVideoViewModel

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height) style:UITableViewStylePlain];
        [_tableView registerClass:[HDFileViewCell class] forCellReuseIdentifier:Cell_Identifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        WeakSelf;
        MJRefreshNormalHeader *freshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf fetchFileData];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        _tableView.mj_header = freshHeader;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (void)fetchFileData {
    self.dataArray = [[HDFileManager shareInstance] fetchLocalFilesWithDesPath:Document_Path];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HDFileViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_Identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[HDFileViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell_Identifier];
    }
    HDFileModel *model = self.dataArray[indexPath.row];
    [cell setCellModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HDFileModel *model = self.dataArray[indexPath.row];
    NSString *filePath = model.filePath;
    NSURL * url = [NSURL fileURLWithPath:filePath];
    VideoViewController *videoViewController = [[VideoViewController alloc] init];
    videoViewController.delegate = _viewController;
    
    MPMoviePlayerController *player = [videoViewController moviePlayer];
    player.controlStyle = MPMovieControlStyleNone;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FinishedCallback:)
//                                                 name:MPMoviePlayerPlaybackDidFinishNotification
//                                               object:nil];
    
    [_viewController presentViewController:videoViewController animated:YES completion:^{
        [videoViewController setVideo:url progress:0];
        [videoViewController play];
    }];
    _viewController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    _viewController.navigationController.navigationBarHidden = YES;
    
//    HDPlayerViewController *playerViewController = [[HDPlayerViewController alloc] init];
//    [self.vieController.navigationController presentViewController:playerViewController animated:YES completion:^{
//        [playerViewController playWithFilePath:filePath];
//    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alertController = [UIAlertController alertViewControllerWithTile:@"呕血提示"
                                                                                    message:@"确定不要了？"
                                                                                  leftTitle:@"不要"
                                                                                 rightTitle:@"要"
                                                                                     hander:^(clickIndex index) {
            if (index == leftIndex) {
                HDFileModel *model = self.dataArray[indexPath.row];
                NSString *filePath = model.filePath;
                [[HDFileManager shareInstance].fileManager removeItemAtPath:filePath error:nil];
                [self.dataArray removeObject:model];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                [self.tableView reloadData];
            }
        }];
        [self.viewController.navigationController presentViewController:alertController animated:YES completion:nil];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"不要了";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
