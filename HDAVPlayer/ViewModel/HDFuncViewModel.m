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
#import "HDClientViewController.h"
#import "HDServerViewController.h"
#import "HDImageListViewController.h"
#import "HDCoreAnimationViewController.h"
#import "WaterFlowViewController.h"
#import "WKWebViewController.h"

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
        _dataArray = [NSMutableArray arrayWithObjects:@"视频", @"生成二维码",@"扫描二维码", @"语音播报",@"通讯Server", @"通讯Client", @"图片预览", @"核心动画", @"瀑布流", @"JS-OC交互", nil];
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
    UIViewController *pushViewController = nil;
    if (indexPath.row == 0) {
        pushViewController = [[HDFileListViewController alloc] init];
    } else if (indexPath.row == 1) {
        pushViewController = [[HDQRCodeShowViewController alloc] init];
    } else if (indexPath.row == 2) {
        pushViewController = [[HDQRCodeScanViewController alloc] init];
    } else if (indexPath.row == 3) {
        pushViewController = [[HDVoiceSpeakViewController alloc] init];
    } else if (indexPath.row == 4) {
        pushViewController = [[HDServerViewController alloc] init];
    } else if (indexPath.row == 5) {
        pushViewController = [[HDClientViewController alloc] init];
    } else if (indexPath.row == 6) {
        pushViewController = [[HDImageListViewController alloc] init];
    } else if (indexPath.row == 7) {
        pushViewController = [[HDCoreAnimationViewController alloc] init];
    } else if (indexPath.row == 8) {
        pushViewController = [[WaterFlowViewController alloc] init];
    } else if (indexPath.row == 9) {
        pushViewController = [[WKWebViewController alloc] init];
    }
    if (pushViewController) {
        [self.vieController.navigationController pushViewController:pushViewController animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


@end
