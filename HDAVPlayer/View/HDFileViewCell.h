//
//  HDFileViewCell.h
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDFileModel.h"

@interface HDFileViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageV;

@property (nonatomic, strong) UILabel *fileNameLabel;

- (void)setCellModel:(HDFileModel *)model;

@end
