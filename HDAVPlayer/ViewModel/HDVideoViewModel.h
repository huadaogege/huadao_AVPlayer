//
//  HDVideoViewModel.h
//  HDAVPlayer
//
//  Created by huadao on 2017/7/17.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDViewModel.h"
#import <UIKit/UIKit.h>

@interface HDVideoViewModel : HDViewModel 

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) UIImage *iconImg;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIViewController *vieController;

- (void)fetchFileData;

@end
