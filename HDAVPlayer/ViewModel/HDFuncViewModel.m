//
//  HDFuncViewModel.m
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDFuncViewModel.h"
#import "HDFileListViewController.h"
#import "HDQRCodeScanViewController.h"
#import "HDQRCodeShowViewController.h"
#import "HDVoiceSpeakViewController.h"

#define Cell_Identifier @"__funclistcellidentifier"

@implementation HDFuncViewModel

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height) style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Cell_Identifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"视频", @"生成二维码",@"扫描二维码", @"语音播报", nil];
    }
    return _dataArray;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_Identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell_Identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HDFileListViewController *fileListViewController = [[HDFileListViewController alloc] init];
        [self.vieController.navigationController pushViewController:fileListViewController animated:YES];
    } else if (indexPath.row == 1) {
        HDQRCodeShowViewController *QRCodeShowViewController = [[HDQRCodeShowViewController alloc] init];
        [self.vieController.navigationController pushViewController:QRCodeShowViewController animated:YES];
    } else if (indexPath.row == 2) {
        HDQRCodeScanViewController *QRCodeScanViewController = [[HDQRCodeScanViewController alloc] init];
        [self.vieController.navigationController pushViewController:QRCodeScanViewController animated:YES];
    } else if (indexPath.row == 3) {
        HDVoiceSpeakViewController *VoiceSpeakViewController = [[HDVoiceSpeakViewController alloc] init];
        [self.vieController.navigationController pushViewController:VoiceSpeakViewController animated:YES];
    }
}


@end