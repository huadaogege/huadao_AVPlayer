//
//  imageListCell.h
//  HDAVPlayer
//
//  Created by huadao on 2017/11/21.
//  Copyright © 2017年 崔玉冠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDImageModel.h"

@interface imageListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *miniImage;

@property (strong, nonatomic) IBOutlet UILabel *fileNameLabel;

- (void)setContent:(HDImageModel *)model;


@end
