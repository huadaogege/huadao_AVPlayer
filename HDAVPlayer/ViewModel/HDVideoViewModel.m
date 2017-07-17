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

#define Cell_Identifier @"__filelistcellidentifier"

@implementation HDVideoViewModel

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height) style:UITableViewStylePlain];
        [_tableView registerClass:[HDFileViewCell class] forCellReuseIdentifier:Cell_Identifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
    HDPlayerViewController *playerViewController = [[HDPlayerViewController alloc] init];
    [self.vieController.navigationController presentViewController:playerViewController animated:YES completion:^{
        [playerViewController playWithFilePath:filePath];
    }];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"呕血提醒" message:@"确定不要了？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            HDFileModel *model = self.dataArray[indexPath.row];
            NSString *filePath = model.filePath;
            [[HDFileManager shareInstance].fileManager removeItemAtPath:filePath error:nil];
            [self.dataArray removeObject:model];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:actionDone];
        [alertController addAction:actionCancel];
        [self.vieController.navigationController presentViewController:alertController animated:YES completion:nil];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"不要了";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
