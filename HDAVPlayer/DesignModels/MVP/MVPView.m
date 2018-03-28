//
//  MVPView.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/3/28.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "MVPView.h"

@implementation MVPView

- (instancetype)init {
    if (self = [super init]) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
        self.contentLabel.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.contentLabel];
    }
    return self;
}

- (void)printContent:(NSString *)content {
    self.contentLabel.text = content;
}

@end
