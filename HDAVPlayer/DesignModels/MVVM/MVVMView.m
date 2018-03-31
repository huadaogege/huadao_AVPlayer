//
//  MVVMView.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/31.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "MVVMView.h"
#import "FBKVOController.h"
#import "NSObject+FBKVOController.h"

@interface MVVMView ()

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) MVVMViewModel *viewModel;

@end

@implementation MVVMView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
        self.contentLabel.font = [UIFont systemFontOfSize:30];
        [self addSubview:self.contentLabel];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 60)];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(printClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)setWithViewModel:(MVVMViewModel *)viewModel {
    self.viewModel = viewModel;
    [self.KVOController observe:viewModel keyPath:@"contentStr" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        self.contentLabel.text = change[NSKeyValueChangeNewKey];
    }];
}

- (void)printClick {
    [self.viewModel printClick];
}

@end
