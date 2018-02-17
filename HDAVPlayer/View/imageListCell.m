//
//  imageListCell.m
//  HDAVPlayer
//
//  Created by huadao on 2017/11/21.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import "imageListCell.h"

@implementation imageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setContent:(HDImageModel *)model {
    self.miniImage.image = model.miniImage;
    self.fileNameLabel.text = model.fileName;
}

@end
