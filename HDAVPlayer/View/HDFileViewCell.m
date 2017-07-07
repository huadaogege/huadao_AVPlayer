//
//  HDFileViewCell.m
//  AVPlayerDemo
//
//  Created by huadao on 2017/7/4.
//  Copyright © 2017年 huadao. All rights reserved.
//

#import "HDFileViewCell.h"

@implementation HDFileViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellHeigth = 60.0;
        self.iconImageV.frame = CGRectMake(20.0, (cellHeigth - 40.0) / 2.0, 60.0, 40.0);
        [self addSubview:self.iconImageV];
        
        CGFloat iconOrigin_X = self.iconImageV.frame.origin.x + self.iconImageV.frame.size.width + 10.0;
        self.fileNameLabel.frame = CGRectMake(iconOrigin_X, (cellHeigth - 30.0) / 2.0, 200.0, 30.0);
        [self addSubview:self.fileNameLabel];
    }
    return self;
}

- (UIImageView *)iconImageV {
    if (!_iconImageV) {
        _iconImageV = [[UIImageView alloc] init];
        _iconImageV.backgroundColor = [UIColor cyanColor];
    }
    return _iconImageV;
}

- (UILabel *)fileNameLabel {
    if (!_fileNameLabel) {
        _fileNameLabel = [[UILabel alloc] init];
        _fileNameLabel.textAlignment = NSTextAlignmentLeft;
        _fileNameLabel.font = [UIFont systemFontOfSize:15.0];
        _fileNameLabel.textColor = [UIColor grayColor];
    }
    return _fileNameLabel;
}

- (void)setCellModel:(HDFileModel *)model {
    self.fileNameLabel.text = model.fileName;
    self.iconImageV.image = model.iconImg;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
