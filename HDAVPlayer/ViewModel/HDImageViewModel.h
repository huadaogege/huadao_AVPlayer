//
//  HDImageViewModel.h
//  HDAVPlayer
//
//  Created by huadao on 2017/11/21.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "HDViewModel.h"

@interface HDImageViewModel : HDViewModel

@property (nonatomic, strong) NSArray *dataArray;

@property (strong, nonatomic) UIViewController *viewController;

- (void)prepareImageData;

@end
