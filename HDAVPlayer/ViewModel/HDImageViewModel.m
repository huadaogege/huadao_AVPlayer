//
//  HDImageViewModel.m
//  HDAVPlayer
//
//  Created by huadao on 2017/11/21.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDImageViewModel.h"
#import "HDImageManager.h"
#import "imageListCell.h"
#import "ImagePreViewController.h"

@implementation HDImageViewModel

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)prepareImageData {
    self.dataArray = [[HDImageManager shareInstance] prepareImagedata];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    imageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageListCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[imageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imageListCell"];
    }
    HDImageModel *model = [[HDImageModel alloc] init];
    if (self.dataArray.count > indexPath.row) {
        model = self.dataArray[indexPath.row];
    }
    [cell setContent:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ImagePreViewController *imagePreViewController = [[ImagePreViewController alloc] init];
    imagePreViewController.dataArray = self.dataArray;
    [self.viewController.navigationController pushViewController:imagePreViewController animated:YES];
}

@end
