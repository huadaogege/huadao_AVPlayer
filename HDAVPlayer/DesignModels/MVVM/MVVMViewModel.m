//
//  MVVMViewModel.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/31.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "MVVMViewModel.h"
#import "MVVMModel.h"

@interface MVVMViewModel ()

@property (nonatomic, strong) MVVMModel *model;

@end

@implementation MVVMViewModel

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setWithModel:(MVVMModel *)model {
    self.model = model;
    self.contentStr = model.contentStr;
}

- (void)printClick {
    static int i = 0;
    i ++;
    self.model.contentStr = [NSString stringWithFormat:@"line %d", i];
    self.contentStr = self.model.contentStr;
}

@end
